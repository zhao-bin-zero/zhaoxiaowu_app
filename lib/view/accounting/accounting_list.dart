import 'package:flutter/material.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/global/global.dart';
import 'package:zhaoxiaowu_app/utils/event_utils.dart';

class AccoutingView extends StatefulWidget {
  @override
  _AccoutingViewState createState() => _AccoutingViewState();
}

class _AccoutingViewState extends State<AccoutingView> {
  List _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("记账"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text("2021年")),
                Expanded(child: Text("本月预算")),
                Expanded(child: Text("收入")),
                Expanded(child: Text("支出")),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text("5月")),
                Expanded(child: Text("2500.0")),
                Expanded(child: Text("200")),
                Expanded(child: Text("500")),
              ],
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: _itemBuilder,
              itemCount: _data == null ? 0 : _data.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _data[index]["date"],
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Text(
                "收入:" + _data[index]["income"].toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(width: 8),
              Text(
                "支出:" + _data[index]["expenditure"].toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Divider(height: 1),
        Column(
          children: _childrens(_data[index]["data"]),
        ),
      ],
    );
  }

  List<Widget> _childrens(var datas) {
    List<Widget> widgets = [];
    for (var i = 0; i < datas.length; i++) {
      widgets.add(Row(
        children: [
          Icon(Icons.add),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(datas[i]["type"]["action"] == 0 ? "收入" : "支出"),
                Text("描述：" + datas[i]["desc"]),
              ],
            ),
          ),
          Text(datas[i]["money"].toString()),
        ],
      ));
      widgets.add(Container(height: 8));
    }
    return widgets;
  }

  void loadData() async {
    var result = await Global.getInstance().dio.get(
      "/zxw/AccountingHistory",
      queryParameters: {
        "date": "202104",
      },
    );
    setState(() {
      if (result.data["success"]) {
        _data = result.data["data"]["data"];
      } else {
        postMessage("fail", result.data["msg"]);
      }
    });
  }
}
