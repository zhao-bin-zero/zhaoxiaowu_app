import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zhaoxiaowu_app/base/view.dart';
import 'package:zhaoxiaowu_app/global/global.dart';

class LoveImageView extends StatefulWidget {
  const LoveImageView({Key key}) : super(key: key);

  @override
  _LoveImageViewState createState() => _LoveImageViewState();
}

class _LoveImageViewState extends State<LoveImageView> {
  final picker = ImagePicker();
  List _imgs;

  Future getImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("拍照"),
              trailing: Icon(Icons.camera_alt),
              onTap: _camera,
            ),
            ListTile(
              title: Text("图片选择"),
              trailing: Icon(Icons.gavel_outlined),
              onTap: _gallery,
            ),
            ListTile(
              title: Text("取消"),
              trailing: Icon(Icons.cancel),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _gallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    uploadFile(pickedFile.path);
  }

  void _camera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    uploadFile(pickedFile.path);
  }

  void uploadFile(String path) async {
    File file = File(path);
    CompressObject compressObject = CompressObject(
      imageFile: file, //image
      path: file.path.substring(
        0,
        file.path.lastIndexOf("/"),
      ), //compress to path
    );
    Luban.compressImage(compressObject).then((_path) async {
      String filename = _path.substring(_path.lastIndexOf("/") + 1);
      var result = await Global.getInstance().dio.post(
            "/zxw/Imgs",
            data: FormData.fromMap(
              {
                'file': await MultipartFile.fromFile(
                  _path,
                  filename: filename,
                ),
              },
            ),
          );
      if (result.data["success"]) {
        EasyLoading.showSuccess(result.data["msg"]);
        loadData();
      } else {
        EasyLoading.showError(result.data["msg"]);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    var result = await Global.getInstance().dio.get("/zxw/Imgs");
    print(result.data);
    if (result.data["success"]) {
      setState(() {
        _imgs = result.data["data"];
      });
    } else {
      EasyLoading.showError(result.data["msg"]);
    }
  }

  void _delete(int id) async {
    print(id.toString());
    var result = await Global.getInstance().dio.delete(
      "/zxw/Imgs",
      data: {
        "id": id.toString(),
      },
    );
    if (result.data["success"]) {
      EasyLoading.showSuccess(result.data["msg"]);
      loadData();
    } else {
      EasyLoading.showError(result.data["msg"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("图片列表"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: getImage,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: EdgeInsets.all(10.0),
        children: _itemBuilder(),
      ),
    );
  }

  List<Widget> _itemBuilder() {
    List<Widget> widgets = List();
    if (_imgs != null) {
      for (var e in _imgs) {
        widgets.add(
          Stack(
            children: [
              Image.network(
                e["url"],
                fit: BoxFit.fill,
                width: 200,
                height: 200,
              ),
              GestureDetector(
                onTap: () {
                  _delete(e["id"]);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.delete),
                ),
              ),
            ],
          ),
        );
      }
    }
    return widgets;
  }
}
