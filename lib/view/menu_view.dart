import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/global/global.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbarActions(
        "菜单",
        [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed("theme");
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("王众"),
              accountEmail: Text(
                "81024198@qq.com",
              ),
            ),
            WeCell(
              label: "支出上限",
              content: Global.getInstance().user["money"].toString(),
              footer: Icon(Icons.navigate_next),
              onClick: () {},
            ),
            Divider(height: 1),
            WeCell(
              label: "注册日期",
              content: Global.getInstance().user["date"],
              footer: Icon(Icons.navigate_next),
              onClick: () {
                Navigator.pop(context);
              },
            ),
            Divider(height: 1),
            WeCell(
              label: "退出登陆",
              content: "",
              footer: Icon(Icons.exit_to_app),
              onClick: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.remove("token");
                Navigator.of(context).popAndPushNamed("/");
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(Global.getInstance().user["name"]),
      ),
    );
  }
}
