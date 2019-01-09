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
        'Content-Type': 'application/json'
      },
    );
    _dio = new Dio(_options);
    _dio.interceptor.request.onSend = (Options options) {
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
      Map map = new Map();
      map['Authorization'] = _token;
      _dio.options.headers.addAll(map);
    }
  }

  get(url, {data, options, cancelToken}) async {
    print('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.get(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      print('get请求成功!response.data：${response.data}');
      return response.data;
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      }
      print('get请求发生错误：$e');
    }
    return null;
  }

  post(url, {data, options, cancelToken}) async {
    print('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      print('post请求成功!response.data：${response.data}');
      return response.data;
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return null;
  }
}