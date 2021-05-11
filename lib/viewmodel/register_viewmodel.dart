import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/model/register_model.dart';
import 'package:zhaoxiaowu_app/utils/rsa/rsa_utils.dart';

class RegisterViewmodel extends ChangeNotifier {
  bool _loading = false;

  bool get getLoading {
    return _loading;
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(String user, String pass, String name, String phone, String code,
      int gender, String dateTime, int solar) async {
    String pwd = await encodeString(pass);
    Response result = await registerModel(json.encode({
      "username": user,
      "password": pwd,
      "phone": phone,
      "name": name,
      "gender": gender,
      "birthday": dateTime,
      "solar": solar,
    }));
    print(result);
    if (result.data["success"]) {
      // Navigator.of(navigaorKey.currentContext).popAndPushNamed("menu");
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
