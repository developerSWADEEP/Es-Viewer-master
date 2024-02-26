import 'dart:io';
import 'package:flutter/material.dart';
import 'package:es_viewer/utils/constant.dart';



class ViewTextFiles extends StatefulWidget {
  final String? path;

  ViewTextFiles({Key? key, this.path}) : super(key: key);
  @override
  _ViewTextFilesState createState() => _ViewTextFilesState();
}

class _ViewTextFilesState extends State<ViewTextFiles> {
  String fileContent = '';

  @override
  void initState() {
    super.initState();
    loadTextFile(widget.path).then((content) {
      setState(() {
        fileContent = content;
      });
    });
  }

  Future<String> loadTextFile(path) async {
    try {
      // Replace 'assets/sample.txt' with the path to your text file
      final file = File(path);

      // If you want to load a text file from external storage, use the FilePicker or other methods
      // final file = File('/path/to/your/external/storage/file.txt');

      String content = await file.readAsString();
      return content;
    } catch (e) {
      return 'Error loading file: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(Constant.title),
        backgroundColor: Colors.transparent, // Set the background color to transparent
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff33ccff),
                Color(0xffff99cc),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              fileContent,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
