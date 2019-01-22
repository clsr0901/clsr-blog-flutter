import 'package:blog/entity/error/Err.dart';
import 'package:blog/http/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio _dio;
  Options _options;
  String _token;

  static HttpUtil getInstance() {
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    // 或者通过传递一个 `options`来创建dio实例
    _options = Options(
      // 请求基地址,可以包含子路径，
      baseUrl: Api.BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 60000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: {
        'Accept': 'application/json',
//        'Content-Type': 'application/json'
      },
    );
    _dio = new Dio(_options);
    _dio.interceptor.request.onSend = (Options options) {
//      print("optoins");
//      print(options.headers.toString());
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    };
    _dio.interceptor.response.onSuccess = (Response response) {
      // Do something with response data
      return response; // continue
    };
    _dio.interceptor.response.onError = (DioError e) {
      if (e.response != null) {
        // Do something with response error
        Err err = Err.fromJson(e.response.data);
        Fluttertoast.showToast(
            msg: err.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white);
      }
      return e; //continue
    };
  }

  setToken(String token) {
    _token = token;
    if (_dio != null) {
      Map<String, String> map = new Map<String, String>();
      map['Authorization'] = _token;
      _dio.options.headers.addAll(map);
    }
    print("设置token");
    print(_dio.options.headers.toString());
  }

//  setFormDataHeaders(){
//    _dio.options.headers.remove("Content-Type");
//  }

  Future put(url, {data, options, cancelToken}) async {
    print('put请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.put(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      print('put请求成功!response.data：${response.data}');
      return new Future(() => response.data);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('put请求取消! ' + e.message);
      }
      print('put请求发生错误：$e');
      throw e;
    }
  }

  Future delete(url, {data, options, cancelToken}) async {
    print('delete请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.delete(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      print('delete请求成功!response.data：${response.data}');
      return new Future(() => response.data);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('delete请求取消! ' + e.message);
      }
      print('delete请求发生错误：$e');
      throw e;
    }
  }

  Future post(url, {data, options, cancelToken}) async {
    print('post请求启动!,options:');
    print(_dio.options.headers);
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      print('post请求成功!response.data：${response.data}');
      return new Future(() => response.data);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
      throw e;
    }
  }

  Future get(url, {data, options, cancelToken}) async {
    print(
      'get请求启动! url：$url ,body: $data, options:$options',
    );
    print("请求头");
    print(_dio.options.headers.toString());
    Response response;
    try {
      response = await _dio.get(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      print('get请求成功!response.data：${response.data}');
      return new Future(() => response.data);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
      throw e;
    }
  }

  Future download(url, savePath, fallback) async {
    Response response;
    try {
      response = await _dio.download(url, savePath,
          // Listen the download progress.
          onProgress: (received, total) {
        fallback(received / total);
      });
      return new Future(() => response.data);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
