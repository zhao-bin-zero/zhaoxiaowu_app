import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/viewmodel/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.read<LoginViewmodel>().getUser.dispose();
    context.read<LoginViewmodel>().getPass.dispose();
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
              controller: Provider.of<LoginViewmodel>(context).getUser,
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock),
              ),
              controller: Provider.of<LoginViewmodel>(context).getPass,
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

  void _login() {
    context.read<LoginViewmodel>().setIsLogin(true);
    new Timer(
      Duration(seconds: 3),
      () {
        context.read<LoginViewmodel>().setIsLogin(false);
        Navigator.of(context).pushNamed("menu");
      },
    );
  }

  void _register() {
    Navigator.of(context).pushNamed("register");
  }
}
