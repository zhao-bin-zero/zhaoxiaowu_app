import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/base/view.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("菜单"),
    );
  }
}