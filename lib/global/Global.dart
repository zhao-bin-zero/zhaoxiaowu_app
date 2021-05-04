import 'package:dio/dio.dart';

class Global {
  static Global _instance;
  Dio dio;

  static Global getInstance() {
    if (_instance == null) _instance = new Global();
    return _instance;
  }

  Global() {
    dio = new Dio();
    dio.options = BaseOptions(
      baseUrl: "https://zxw.td0f7.cn/",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        "token": "3213131",
      },
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
    );
    dio.interceptors.add(InterceptorsWrapper(
      // onRequest: (options) {
      //   print("请求" + options.headers.toString());
      //   print("请求" + options.extra.toString());
      // },
      // onResponse: (e) {
      //   print("返回" + e.toString());
      // },
      onError: (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          print("连接超时错误");
        } else {
          print("接口错误！");
        }
      },
    ));
  }
}
