import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:weui/form/index.dart';
import 'package:weui/input/index.dart';
import 'package:weui/weui.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/eventbus/event_bus.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/utils/date_utils.dart';
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
  DateTime _dateTime;
  int _gender = 0; //0=男 1=女
  int _solar = 0; //0=阳历 1=阴历/农历
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = TextEditingController();
    _pass = TextEditingController();
    _phone = TextEditingController();
    _code = TextEditingController();
    _name = TextEditingController();
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
    _phone.dispose();
    _code.dispose();
    _name.dispose();
    bus.off("fail");
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
              count > 0 ? count.toString() + "秒后再次获取" : "获取验证码",
              disabled: count > 0 ? true : false,
              theme: WeButtonType.primary,
              size: WeButtonSize.mini,
              onClick: _getCode,
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
                  checked: _gender == 0 ? false : true,
                  onChange: (v) {
                    setState(() {
                      _gender = v ? 1 : 0;
                    });
                  },
                ),
                SizedBox(width: 8),
                Text(
                  _gender == 0 ? "男" : "女",
                ),
              ],
            ),
            onChange: (v) {
              _name.text = v;
            },
          ),
          WeCell(
            label: "出生日期",
            content: getYMD(_dateTime),
            align: Alignment.center,
            footer: Row(
              children: [
                WeSwitch(
                  size: 20,
                  checked: _solar == 0 ? false : true,
                  onChange: (v) {
                    setState(() {
                      _solar = v ? 1 : 0;
                    });
                  },
                ),
                SizedBox(width: 8),
                Text(
                  _solar == 0 ? "阳历" : "阴历",
                ),
              ],
            ),
            onClick: () async {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2010, 1, 1),
                  maxTime: DateTime(2050, 1, 1),
                  onChanged: (date) {}, onConfirm: (date) {
                setState(() {
                  _dateTime = date;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.zh);
            },
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: WeButton(
              "注册",
              theme: WeButtonType.warn,
              onClick: _register,
            ),
          ),
        ],
      ),
    );
  }

  void _getCode() {
    setState(() {
      count = 60;
    });
    _task();
  }

  void _task() {
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        count--;
        if (count > 0) {
          _task();
        }
      });
    });
  }

  void _register() {
    if (_user.text == null || _user.text.isEmpty) {
      WeToast.fail(context)(message: "账号不能为空！");
      return;
    } else if (_pass.text == null || _pass.text.isEmpty) {
      WeToast.fail(context)(message: "密码不能为空！");
      return;
    } else if (_name.text == null || _name.text.isEmpty) {
      WeToast.fail(context)(message: "姓名不能为空！");
      return;
    } else if (_phone.text == null || _phone.text.isEmpty) {
      WeToast.fail(context)(message: "手机号不能为空！");
      return;
    } else if (_code.text == null || _code.text.isEmpty) {
      WeToast.fail(context)(message: "验证码不能为空！");
      return;
    } else if (_dateTime == null) {
      WeToast.fail(context)(message: "生日不能为空！");
      return;
    }
    Global.getInstance().context = context;
    context.read<RegisterViewmodel>().login(
          _user.text,
          _pass.text,
          _name.text,
          _phone.text,
          _code.text,
          _gender,
          getYMD(_dateTime),
          _solar,
        );
  }
}
