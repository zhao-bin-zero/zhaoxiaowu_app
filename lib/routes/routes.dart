import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/view/accounting/accounting_chart.dart';
import 'package:zhaoxiaowu_app/view/accounting/accounting_list.dart';
import 'package:zhaoxiaowu_app/view/accounting/accouting_add.dart';
import 'package:zhaoxiaowu_app/view/love_image/love_image.dart';
import 'package:zhaoxiaowu_app/view/user/login_view.dart';
import 'package:zhaoxiaowu_app/view/menu_view.dart';
import 'package:zhaoxiaowu_app/view/user/register_view.dart';
import 'package:zhaoxiaowu_app/view/theme/settings_theme.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => LoginView(),
  "menu": (BuildContext context) => MenuView(),
  "register": (BuildContext context) => RegisterView(),
  "theme": (BuildContext context) => SettingsTheme(),
  "accouting": (BuildContext context) => AccoutingView(),
  "accouting/add": (BuildContext context) => AccoutingAddView(),
  "accouting/chart": (BuildContext context) => AccountingChartView(),
  "loveImage": (BuildContext context) => LoveImageView(),
};
