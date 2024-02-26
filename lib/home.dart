import 'package:es_viewer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:es_viewer/utils/func.dart';
import 'package:es_viewer/uri_to_file.dart';
import 'package:upgrader/upgrader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    //This method will call when user is opening file from share method /when app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> files) {
      if (files != null) {
        print(files.map((f) => f.path).join(","));
        func.openFile(context, files.map((f) => f.path).join(","));
      }
    });

    //this method will when user select file from open with method /when app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value != null) {
        toFile(value).then((value) => {
          func.openFile(context, value.path.toString()),
        });
      }
    });
  }

  Widget fileCircle() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 12.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff33ccff),
            Color(0xffff99cc),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.ac_unit_rounded, // Replace with your desired icon
          size: 60.0, // Adjust the icon size to your preference
          color: Colors.white, // Customize the icon color
        ),
      ),
    );
  }

  Widget selectFile() {
    return Container(
      height: 60,
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff33ccff),
              Color(0xffff99cc),
            ],
          )),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open, // Replace with your desired icon
              size: 30.0, // Adjust the icon size to your preference
              color: Colors.white, // Customize the icon color
            ),
            SizedBox(width: 10),
            Text(
              'Open File',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.title,
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          func.showExitConfirmationDialog(context);
          return false;
        },
        child: UpgradeAlert(
          child: Scaffold(
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
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Container(child: fileCircle()),
                    SizedBox(height: 30),
                    Text("Click on open file button to open \n File/Documents",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                        color: Colors.black,
                         fontSize: 16)),
                    SizedBox(height:280),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          func.selectPdf(context);
                        },
                        child: selectFile(),
                      ),
                    ),
                    Expanded(child: Text("")),

                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
