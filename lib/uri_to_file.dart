import 'dart:io';
import 'package:flutter/services.dart';
const MethodChannel _methodChannel =
    const MethodChannel('in.lazymanstudios.uritofile/helper');
bool isUriSupported(String uriString) {
  Uri uri = Uri.parse(uriString);
  if (Platform.isAndroid && uri.isScheme('content')) {
    return true;
  }
  try {
    File.fromUri(uri);
    return true;
  } catch (e) {
    return false;
  }
}
Future<File> toFile(String uriString) async {
  Uri uri = Uri.parse(uriString);
  if (Platform.isAndroid && uri.isScheme('content')) {
    try {
      String filepath = await _methodChannel
          .invokeMethod("fromUri", {"uriString": uriString});
      return File(filepath);
    }catch (e) {
      print(e);
    }
  }
  return File.fromUri(uri);
}
