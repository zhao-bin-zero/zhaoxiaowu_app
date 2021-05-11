import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/main.dart';
import 'package:zhaoxiaowu_app/model/login_model.dart';
import 'package:zhaoxiaowu_app/utils/event_utils.dart';

class LoginViewmodel extends ChangeNotifier {
  bool _isLogin = false;

  bool get getIsLogin {
    return _isLogin;
  }

  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void login(String user, String pass) async {
    Response result = await loginModel(user, pass);
    print(result);
    if (result.data["success"]) {
      Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
    } else {
      postMessage("fail", result.data["msg"]);
    }
    setIsLogin(false);
  }
}
