import 'package:flutter/material.dart';

AppBar getAppbar(String title) {
  return AppBar(
    title: Text(title),
    elevation: 10,
    centerTitle: true,
  );
}

AppBar getAppbarActions(String title, List<Widget> actions) {
  return AppBar(
    title: Text(title),
    elevation: 10,
    centerTitle: true,
    actions: actions,
  );
}

AppBar getAppbarActionsAndLeading(
    String title, List<Widget> actions, Widget leading) {
  return AppBar(
    leading: leading,
    title: Text(title),
    elevation: 10,
    centerTitle: true,
    actions: actions,
  );
}
