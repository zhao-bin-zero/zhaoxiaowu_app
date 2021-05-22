import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/base/view.dart';

class AccoutingAddView extends StatefulWidget {
  @override
  _AccoutingAddViewState createState() => _AccoutingAddViewState();
}

class _AccoutingAddViewState extends State<AccoutingAddView> {
  TextEditingController _money;
  TextEditingController _desc;

  @override
  void initState() {
    _money = TextEditingController();
    _desc = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _money.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("新增记账"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("类型"),
              trailing: Text("data"),
            ),
            Divider(height: 1),
            ListTile(
              title: Text("方式"),
              trailing: Text("data"),
            ),
            Divider(height: 1),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入金额",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: true,
                controller: _money,
              ),
            ),
            Divider(height: 1),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入备注",
                ),
                textInputAction: TextInputAction.send,
                controller: _desc,
              ),
            ),
            Divider(height: 1),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: RaisedButton(
                onPressed: _submit,
                child: Text("新增"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {}
}
