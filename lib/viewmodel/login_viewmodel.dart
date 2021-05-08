import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/main.dart';
import 'package:zhaoxiaowu_app/model/login_model.dart';

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
    setIsLogin(true);
    if (user.isEmpty) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "账号不能为空！",
        },
      );
      setIsLogin(false);
      return;
    } else if (pass.isEmpty) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "密码不能为空！",
        },
      );
      setIsLogin(false);
      return;
    }
    Response result = await loginModel(user, pass);
    print(result);
    if (result.data["success"]) {
      Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
    } else {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": result.data["msg"],
        },
      );
    }
    setIsLogin(false);
  }
}
