import 'package:flutter/material.dart';
import 'package:weui/form/index.dart';
import 'package:weui/input/index.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/base/view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("注册"),
      body: WeForm(
        children: [
          WeInput(
            label: "登陆账号",
            hintText: "请输入登陆用户名",
            clearable: true,
            textInputAction: TextInputAction.next,
          ),
          WeInput(
            label: "手机号码",
            hintText: "请输入手机号码",
            textInputAction: TextInputAction.send,
            type: TextInputType.phone,
            footer: WeButton(
              "获取验证码",
              theme: WeButtonType.primary,
              size: WeButtonSize.mini,
            ),
          ),
          WeInput(
            label: "验证码",
            hintText: "请输入获取到的验证码",
            textInputAction: TextInputAction.next,
            type: TextInputType.number,
            clearable: true,
          ),
          WeInput(
            label: "登陆密码",
            hintText: "请输入登陆密码",
            textInputAction: TextInputAction.next,
            clearable: true,
            obscureText: true,
          ),
          WeInput(
            label: "中文姓名",
            hintText: "请输入中文姓名",
            textInputAction: TextInputAction.next,
            footer: Row(
              children: [
                WeSwitch(
                  size: 20,
                ),
                SizedBox(width: 8),
                Text("男"),
              ],
            ),
          ),
          WeCell(
            label: "出生日期",
            content: "",
            footer: Row(
              children: [
                WeSwitch(
                  size: 20,
                ),
                SizedBox(width: 8),
                Text("阴历"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: WeButton(
              "注册",
              theme: WeButtonType.warn,
            ),
          ),
        ],
      ),
    );
  }
}
