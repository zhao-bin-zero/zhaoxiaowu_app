import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:weui/form/index.dart';
import 'package:weui/input/index.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _user;
  TextEditingController _pass;
  TextEditingController _phone;
  TextEditingController _code;
  TextEditingController _name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = TextEditingController();
    _pass = TextEditingController();
    _phone = TextEditingController();
    _code = TextEditingController();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
    _phone.dispose();
    _code.dispose();
    _name.dispose();
  }

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
            onChange: (v) {
              _user.text = v;
            },
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
            onChange: (v) {
              _phone.text = v;
            },
          ),
          WeInput(
            label: "验证码",
            hintText: "请输入获取到的验证码",
            textInputAction: TextInputAction.next,
            type: TextInputType.number,
            clearable: true,
            onChange: (v) {
              _code.text = v;
            },
          ),
          WeInput(
            label: "登陆密码",
            hintText: "请输入登陆密码",
            textInputAction: TextInputAction.next,
            clearable: true,
            obscureText: true,
            onChange: (v) {
              _pass.text = v;
            },
          ),
          WeInput(
            label: "中文姓名",
            hintText: "请输入中文姓名",
            textInputAction: TextInputAction.next,
            footer: Row(
              children: [
                WeSwitch(
                  size: 20,
                  checked:
                      Provider.of<RegisterViewmodel>(context).getGender == 0
                          ? false
                          : true,
                  onChange: (v) {
                    context.read<RegisterViewmodel>().setGender(v ? 1 : 0);
                  },
                ),
                SizedBox(width: 8),
                Text(
                  Provider.of<RegisterViewmodel>(context).getGender == 0
                      ? "男"
                      : "女",
                ),
              ],
            ),
            onChange: (v) {
              _name.text = v;
            },
          ),
          WeCell(
            label: "出生日期",
            content: Provider.of<RegisterViewmodel>(context).getDateTime,
            align: Alignment.center,
            footer: Row(
              children: [
                WeSwitch(
                  size: 20,
                  checked: Provider.of<RegisterViewmodel>(context).getSolar == 0
                      ? false
                      : true,
                  onChange: (v) {
                    context.read<RegisterViewmodel>().setSolar(v ? 1 : 0);
                  },
                ),
                SizedBox(width: 8),
                Text(
                  Provider.of<RegisterViewmodel>(context).getSolar == 0
                      ? "阳历"
                      : "阴历",
                ),
              ],
            ),
            onClick: () async {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2010, 1, 1),
                  maxTime: DateTime(2050, 1, 1),
                  onChanged: (date) {}, onConfirm: (date) {
                context.read<RegisterViewmodel>().setDateTime(date);
              }, currentTime: DateTime.now(), locale: LocaleType.zh);
            },
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: WeButton(
              "注册",
              loading: Provider.of<RegisterViewmodel>(context).getLoading,
              theme: WeButtonType.warn,
              onClick: () {
                context.read<RegisterViewmodel>().login(
                      _user.text,
                      _pass.text,
                      _name.text,
                      _phone.text,
                      _code.text,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
