import 'dart:io';
import 'package:es_viewer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as csv;

class CSVViewer extends StatefulWidget {
  final String? path;

  CSVViewer({Key? key, this.path}) : super(key: key);

  @override
  _CSVViewerState createState() => _CSVViewerState();
}

class _CSVViewerState extends State<CSVViewer> {
  late Future<List<List<dynamic>>> csvDataFuture;

  @override
  void initState() {
    super.initState();
    csvDataFuture = loadCSVData(widget.path);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<List<dynamic>>>(
        future: csvDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while data is loading
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Display an error message if there was an error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Display a message if no data is available
            return const Center(
              child: Text(Constant.na),
            );
          } else {
            // Display the DataTable when data is loaded
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: _buildColumns(snapshot.data![0]),
                  rows: _buildRows(snapshot.data!),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  List<DataColumn> _buildColumns(List<dynamic> firstRow) {
    List<DataColumn> columns = [];
    for (int i = 0; i < firstRow.length; i++) {
      columns.add(DataColumn(
        label: Text(firstRow[i].toString()),
      ));
      if (i < firstRow.length - 1) {
        // Add an empty DataCell with a divider appearance
        columns.add(DataColumn(
          label: Container(
            width: 1.0, // Divider width
            color: Colors.grey.shade300, // Divider color
          ),
        ));
      }
    }
    return columns;
  }

  List<DataRow> _buildRows(List<List<dynamic>> data) {
    List<DataRow> rows = [];
    for (int i = 1; i < data.length; i++) {
      List<DataCell> cells = [];
      for (int j = 0; j < data[i].length; j++) {
        cells.add(DataCell(
          Text(data[i][j].toString()),
        ));
        if (j < data[i].length - 1) {
          // Add an empty DataCell with a divider appearance
          cells.add(DataCell(
            Container(
              width: 1.0, // Divider width
              color: Colors.grey.shade300, // Divider color
            ),
          ));
        }
      }
      rows.add(DataRow(cells: cells));
    }
    return rows;
  }

  Future<List<List<dynamic>>> loadCSVData(String? path) async {
    if (path == null || path.isEmpty) {
      // Return an empty list if the path is not provided
      return [];
    }
    String csvString = await File(path).readAsString();
    final csvConverter = csv.CsvToListConverter(eol: '\n', fieldDelimiter: ',');
    return csvConverter.convert(csvString);
  }
}
