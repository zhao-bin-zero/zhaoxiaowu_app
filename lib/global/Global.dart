import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/main.dart';

class Global {
  static Global _instance;
  Dio dio;
  String token;
  Map user;
  BuildContext context;
  var loading;

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
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
    );
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) {
        loading = WeToast.loading(context)(message: "Loading...");
      },
      onResponse: (e) {
        loading();
      },
      onError: (e) {
        loading();
        String msg = "";
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          msg = "连接超时错误";
        } else {
          msg = "接口错误！";
        }
        WeToast.fail(context)(message: msg);
      },
    ));
  }
}
