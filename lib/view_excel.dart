import 'package:es_viewer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';



class ExcelViewerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExcelViewer(),
    );
  }
}

class ExcelViewer extends StatefulWidget {
  @override
  _ExcelViewerState createState() => _ExcelViewerState();
}

class _ExcelViewerState extends State<ExcelViewer> {
  late String excelFilePath;
  late Excel excel;

  @override
  void initState() {
    super.initState();
    loadExcelFile().then((_) {
      setState(() {});
    });
  }

  Future<void> loadExcelFile() async {
    // Replace 'assets/sample.xlsx' with the path to your Excel file
    excelFilePath = 'assets/ex.xls';

    // If you want to load an Excel file from external storage, you can use file_picker or other methods
    // excelFilePath = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);

    var file = File(excelFilePath);
    var bytes = file.readAsBytesSync();
    var excelData = await Excel.decodeBytes(bytes);

    if (excelData.tables.isNotEmpty) {
      excel = excelData;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (excel == null) {
      // Show a loading indicator while Excel data is being loaded
      return Center(child: CircularProgressIndicator());
    } else {
      // Extract data from Excel and display it in a DataTable
      var table = excel.tables[excel.tables.keys.first];

      return Scaffold(
        appBar: AppBar(
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
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: _buildColumns(table!),
              rows: _buildRows(table),
            ),
          ),
        ),
      );
    }
  }

  List<DataColumn> _buildColumns(Sheet sheet) {
    var headers = sheet.row(0).map((cell) => DataColumn(label: Text(cell!.value))).toList();
    return headers;
  }

  List<DataRow> _buildRows(Sheet sheet) {
    var rows = <DataRow>[];
    for (var i = 1; i < sheet.maxRows; i++) {
      var row = sheet.row(i);
      var cells = row.map((cell) => DataCell(Text(cell!.value))).toList();
      rows.add(DataRow(cells: cells));
    }
    return rows;
  }
}
