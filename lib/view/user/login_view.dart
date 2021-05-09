import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/viewmodel/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _user;
  TextEditingController _pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = new TextEditingController();
    _pass = new TextEditingController();
    bus.on("fail", (arg) {
      if (arg["view"] == "login") {
        WeToast.fail(context)(message: arg["message"]);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
    bus.off("fail");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("登陆"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              "images/main.jpg",
              width: double.infinity,
              height: 260,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 16),
            // WeForm(
            //   children: [
            //     WeInput(
            //       autofocus: false,
            //       label: "账号",
            //       hintText: "请输入账号",
            //       clearable: true,
            //       textInputAction: TextInputAction.next,
            //     ),
            //     WeInput(
            //       label: "密码",
            //       hintText: "请输入密码",
            //       clearable: true,
            //       obscureText: true,
            //       textInputAction: TextInputAction.send,
            //     ),
            //   ],
            // ),
            TextField(
              decoration: InputDecoration(
                labelText: "账号",
                hintText: "请输入账号",
                prefixIcon: Icon(Icons.person),
              ),
              controller: _user,
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock),
              ),
              controller: _pass,
              obscureText: true,
              textInputAction: TextInputAction.send,
              onSubmitted: (String) {
                print("submit");
              },
            ),
            SizedBox(height: 16),
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: Text(
                  "找回密码",
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.right,
                ),
              ),
              onTap: () {
                print("找回密码");
              },
            ),
            SizedBox(height: 16),
            WeButton(
              "登陆",
              theme: WeButtonType.primary,
              loading: Provider.of<LoginViewmodel>(context).getIsLogin,
              onClick: _login,
            ),
            SizedBox(height: 8),
            WeButton(
              "注册",
              theme: WeButtonType.primary,
              onClick: _register,
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    context.read<LoginViewmodel>().login(_user.text, _pass.text);
  }

  void _register() {
    Navigator.of(context).pushNamed("register");
  }
}
