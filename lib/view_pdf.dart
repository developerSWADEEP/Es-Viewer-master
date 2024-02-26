import 'package:es_viewer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewPdf extends StatefulWidget {
  final String? path;

  ViewPdf({Key? key, this.path}) : super(key: key);

  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  int? currentPage = 0;
  int? totalPage = 0;
  PDFViewController? pdfController;

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
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true, // Enable swipe gestures for navigation
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page;
                totalPage = total;
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              setState(() {
                pdfController = pdfViewController;
              });
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (currentPage != 0)
                OutlinedButton(
                  onPressed: () {
                    if (pdfController != null && currentPage! > 0) {
                      pdfController!.setPage(currentPage! - 1);
                    }
                  },
                  child: Text('Previous'),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                ),
                Text('Page ${currentPage! + 1} of $totalPage'),
                if (currentPage! < totalPage! - 1)
                  OutlinedButton(
                    onPressed: () {
                      if (pdfController != null && currentPage! < totalPage! - 1) {
                        pdfController!.setPage(currentPage! + 1);
                      }
                    },
                    child: Text('Next'),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
