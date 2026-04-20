import 'dart:io';
import 'package:archive/archive.dart';
import 'package:es_viewer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class ViewDocx extends StatefulWidget {
  final String path;

  const ViewDocx({super.key, required this.path});

  @override
  State<ViewDocx> createState() => _ViewDocxState();
}

class _ViewDocxState extends State<ViewDocx> {
  String _content = '';
  String? _error;

  @override
  void initState() {
    super.initState();
    _readDocx();
  }

  Future<void> _readDocx() async {
    try {
      final bytes = await File(widget.path).readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);
      final documentEntry = archive.findFile('word/document.xml');
      if (documentEntry == null) {
        throw Exception('DOCX content not found');
      }

      final xmlContent = String.fromCharCodes(documentEntry.content as List<int>);
      final document = XmlDocument.parse(xmlContent);
      final textNodes = document.findAllElements(
        't',
        namespace: 'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
      );
      final plainText = textNodes.map((e) => e.innerText).join(' ').trim();

      if (!mounted) return;
      setState(() {
        _content = plainText.isEmpty ? 'This document has no readable text.' : plainText;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Error opening DOCX file: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.title),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
      body: _error != null
          ? Center(child: Padding(padding: const EdgeInsets.all(16), child: Text(_error!)))
          : _content.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Text(_content),
                ),
    );
  }
}
