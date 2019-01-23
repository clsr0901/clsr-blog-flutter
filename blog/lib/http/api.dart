class Api {
  static const String BASE_URL = "http://192.168.1.2:8080/"; //本机ip
//  static String BASE_URL = "http://132.232.92.140:8080/";//云服务器地址
  static const String LOGIN = "login/in";
  static const String GETBLOGS = "blog/post/keyword";
  static const String GETBLOG = "/blog/get/";
  static const String PUTBLOG = "/blog/put/";
  static const String DELETEBLOG = "/blog/delete/";

  static const String DELETCOMMENT = "/comment/delete/";
  static const String GETCOMMENTS = "/comment/get/";
  static const String PUTCOMMENTS = "/comment/put/";

  static const String GETUSER = "/user/get/";

  static const String GETMESSAGE = "/message/get/";
  static const String DELETEMESSAGE = "/message/delete/";
  static const String PUTMESSAGE = "/message/put";

  static const String GETSOURCE = "/source/get/";
  static const String DELETESOURCE = "/source/delete/";

  static const String UPLOADCHUNK = "/upload/chunk";
  static const String UPLOADMERGE = "/upload/merge";


}
