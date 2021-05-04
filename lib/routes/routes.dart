import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/view/login_view.dart';
import 'package:zhaoxiaowu_app/view/menu_view.dart';
import 'package:zhaoxiaowu_app/view/register_view.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => LoginView(),
  "menu": (BuildContext context) => MenuView(),
  "register": (BuildContext context) => RegisterView(),
};
