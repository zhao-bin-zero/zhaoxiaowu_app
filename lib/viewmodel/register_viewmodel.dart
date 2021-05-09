import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/model/register_model.dart';
import 'package:zhaoxiaowu_app/utils/rsa/rsa_utils.dart';

class RegisterViewmodel extends ChangeNotifier {
  bool _loading = false;
  DateTime _dateTime;
  int _gender = 0; //0=男 1=女
  int _solar = 0; //0=阳历 1=阴历/农历

  bool get getLoading {
    return _loading;
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String get getDateTime {
    if (_dateTime == null) return "";
    return _dateTime.year.toString() +
        "-" +
        _dateTime.month.toString() +
        "-" +
        _dateTime.day.toString();
  }

  int get getGender {
    return _gender;
  }

  int get getSolar {
    return _solar;
  }

  void setGender(int v) {
    _gender = v;
    notifyListeners();
  }

  void setSolar(int v) {
    _solar = v;
    notifyListeners();
  }

  void setDateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  void login(
      String user, String pass, String name, String phone, String code) async {
    setLoading(true);
    if (user == null || user.isEmpty) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "账号不能为空！",
        },
      );
      setLoading(false);
      return;
    } else if (pass == null || pass.isEmpty) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "密码不能为空！",
        },
      );
      setLoading(false);
      return;
    } else if (name == null || name.isEmpty) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "姓名不能为空！",
        },
      );
      setLoading(false);
      return;
    } else if (phone == null || phone.isEmpty) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "手机号不能为空！",
        },
      );
      setLoading(false);
      return;
    } else if (code == null || code.isEmpty) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "验证码不能为空！",
        },
      );
      setLoading(false);
      return;
    } else if (_dateTime == null) {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": "生日不能为空！",
        },
      );
      setLoading(false);
      return;
    }
    String pwd = await encodeString(pass);
    Response result = await registerModel(json.encode({
      "username": user,
      "password": pwd,
      "phone": phone,
      "name": name,
      "gender": _gender,
      "birthday": getDateTime,
      "solar": _solar,
    }));
    print(result);
    if (result.data["success"]) {
      // Navigator.of(navigatorKey.currentContext).popAndPushNamed("menu");
    } else {
      bus.emit(
        "fail",
        {
          "view": "login",
          "message": result.data["msg"],
        },
      );
    }
    setLoading(false);
  }
}
