import 'dart:io';

import 'package:es_viewer/utils/s_colors.dart';
import 'package:es_viewer/utils/view_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import '../view_csv.dart';
import '../view_img.dart';
import '../view_pdf.dart';
import '../view_video.dart';

class func {
  static selectPdf(BuildContext context) async {
    String resultPath = 'No file selected';
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'csv',
        'txt',
        'java',
        'dart',
        'py',
        'html',
        'css',
        'js',
        'xml',
        'jpg',
        'png',
        'webp',
        'mp4',
        'avi',
        'mkv',
        'mpg',
        '3gp',
        'webm',
        'flv',
        'wmv',
        'mov'

      ],
    );
    if (result != null) {
      String filePath = result.files.single.path!;
      print(filePath);
      print(result.files.single.extension);
      if (filePath.isNotEmpty) {
        switch (result.files.single.extension) {
          case "pdf":
            goTo(context, ViewPdf(path: filePath));
            break;
          case "csv":
            goTo(context, CSVViewer(path: filePath));
            break;
          case "txt":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "java":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "dart":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "py":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "html":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "css":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "js":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "xml":
            goTo(context, ViewTextFiles(path: filePath));
            break;
          case "jpg":
            goTo(context, ViewImg(path: filePath));
            break;
          case "png":
            goTo(context, ViewImg(path: filePath));
            break;
          case "webp":
            goTo(context, ViewImg(path: filePath));
            break;
          case "mp4":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "avi":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "mkv":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "mpg":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "3gp":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "webm":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "flv":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "wmv":
            goTo(context, ViewVideo(path: filePath));
            break;
          case "mov":
            goTo(context, ViewVideo(path: filePath));
            break;
          // Add more cases as needed
          default:
          // Code to execute if none of the cases match
        }
      }
    } else {
      func.showToast("No file selected");
    }
    return resultPath;
  }

  static openFile(context, filePath) {
    String fileExtension = path.extension(filePath);
    switch (fileExtension) {
      case ".pdf":
        goTo(context, ViewPdf(path: filePath));
        break;
      case ".csv":
        goTo(context, CSVViewer(path: filePath));
        break;
      case ".txt":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".java":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".dart":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".py":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".html":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".css":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".js":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".xml":
        goTo(context, ViewTextFiles(path: filePath));
        break;
      case ".jpg":
        goTo(context, ViewImg(path: filePath));
        break;
      case ".png":
        goTo(context, ViewImg(path: filePath));
        break;
      case ".webp":
        goTo(context, ViewImg(path: filePath));
        break;
      case ".mp4":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".avi":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".mkv":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".mpg":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".3gp":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".webm":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".flv":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".wmv":
        goTo(context, ViewVideo(path: filePath));
        break;
      case ".mov":
        goTo(context, ViewVideo(path: filePath));
        break;
      // Add more cases as needed
      default:
      // Code to execute if none of the cases match
    }
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static goTo(BuildContext context, dynamic myClass) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => myClass,
      ),
    );
  }

  static Future<Future<bool?>> showExitConfirmationDialog(
      BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Close App'),
          content: Text('Are you sure you want to close the app?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // User cancels closing the app
              },
            ),
            ElevatedButton(
              child: Text('Yes'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  static getLoadingUICircular(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
        color: SColors.white.withOpacity(0.4),
        width: width,
        height: height,
        child: const Center(
            heightFactor: 5.0,
            widthFactor: 5.0,
            child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: SColors.smashedPumpkin,
                    valueColor:
                        AlwaysStoppedAnimation(SColors.smashedPumpkin)))));
  }

  static String getFlag(String countryCode) {
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }
}
