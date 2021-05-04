import 'package:flutter/material.dart';

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
}
