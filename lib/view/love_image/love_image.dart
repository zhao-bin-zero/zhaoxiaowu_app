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
  File _image;
  final picker = ImagePicker();
  List _imgs;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File file = File(pickedFile.path);
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
          Image.network(
            e["url"],
            width: 200,
            height: 200,
          ),
        );
      }
    }
    return widgets;
  }
}
