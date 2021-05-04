import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/utils/rsa/rsa_utils.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  void test() async {
    String result = await encodeString("123456");
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
        centerTitle: true,
        elevation: 10,
      ),
    );
  }
}
