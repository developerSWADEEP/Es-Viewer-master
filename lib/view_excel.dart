import 'dart:io';
import 'package:es_viewer/utils/constant.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class ExcelViewer extends StatefulWidget {
  final String path;

  const ExcelViewer({super.key, required this.path});

  @override
  State<ExcelViewer> createState() => _ExcelViewerState();
}

class _ExcelViewerState extends State<ExcelViewer> {
  Excel? excel;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadExcelFile();
  }

  Future<void> loadExcelFile() async {
    try {
      final file = File(widget.path);
      final bytes = await file.readAsBytes();
      final excelData = Excel.decodeBytes(bytes);
      if (!mounted) return;
      setState(() {
        excel = excelData;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'Error opening spreadsheet: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstSheetName = excel?.tables.keys.isNotEmpty == true
        ? excel!.tables.keys.first
        : null;
    final table = firstSheetName != null ? excel!.tables[firstSheetName] : null;

    if (excel == null) {
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
        body: Center(
          child: errorMessage == null
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(errorMessage!),
                ),
        ),
      );
    } else {
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
        body: table == null
            ? const Center(child: Text('No data found in this spreadsheet'))
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: _buildColumns(table),
                    rows: _buildRows(table),
                  ),
                ),
          ),
      );
    }
  }

  List<DataColumn> _buildColumns(Sheet sheet) {
    var headers = sheet
        .row(0)
        .map((cell) => DataColumn(label: Text(cell?.value.toString() ?? "")))
        .toList();
    return headers;
  }

  List<DataRow> _buildRows(Sheet sheet) {
    var rows = <DataRow>[];
    for (var i = 1; i < sheet.maxRows; i++) {
      var row = sheet.row(i);
      var cells =
          row.map((cell) => DataCell(Text(cell?.value.toString() ?? ""))).toList();
      rows.add(DataRow(cells: cells));
    }
    return rows;
  }
}
