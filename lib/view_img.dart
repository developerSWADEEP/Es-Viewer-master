import 'dart:io';
import 'package:es_viewer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ViewImg extends StatefulWidget {
  final String? path;

  ViewImg({Key? key, this.path}) : super(key: key);

  @override
  _ViewImgState createState() => _ViewImgState();
}
class _ViewImgState extends State<ViewImg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider:FileImage(File(widget.path!)),
      ),
    );
  }
}
