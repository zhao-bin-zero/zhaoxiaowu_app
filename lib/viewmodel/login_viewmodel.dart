import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/main.dart';
import 'package:zhaoxiaowu_app/model/login_model.dart';

class LoginViewmodel extends ChangeNotifier {
  bool _isLogin = false;
  TextEditingController _user;
  TextEditingController _pass;

  bool get getIsLogin {
    return _isLogin;
  }

  TextEditingController get getUser {
    if (_user == null) _user = TextEditingController();
    return _user;
  }

  TextEditingController get getPass {
    if (_pass == null) _pass = TextEditingController();
    return _pass;
  }

  void setIsLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  void login(BuildContext context) async {
    setIsLogin(true);
    if (getUser.text.isEmpty) {
      WeToast.fail(context)(message: "账号不能为空！");
      setIsLogin(false);
      return;
    } else if (getPass.text.isEmpty) {
      WeToast.fail(context)(message: "密码不能为空！");
      setIsLogin(false);
      return;
    }
    Response result = await loginModel(getUser.text, getPass.text);
    if (result.data["success"]) {
      Navigator.of(context).popAndPushNamed("menu");
    } else {
      WeDialog.alert(context)(result.data["msg"]);
    }
    setIsLogin(false);
  }
}
