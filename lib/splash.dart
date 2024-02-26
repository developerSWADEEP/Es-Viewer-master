import 'dart:async';
import 'package:es_viewer/utils/constant.dart';
import 'package:es_viewer/utils/s_colors.dart';
import 'package:es_viewer/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:es_viewer/utils/func.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool sloginState = false;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()
                      ))
            });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset('assets/logo.png', width: 160, height:80)),
            const TextWidget(label:Constant.label),
          ]),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(vertical: 9),
            color: SColors.cultured,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: Constant.madeFrom,
                      style: GoogleFonts.nunito(
                          color: SColors.independence,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                            text: func.getFlag('in'),
                            style: GoogleFonts.nunito(
                                color: SColors.redPigment,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        TextSpan(
                            text: ' with \u2764 ',
                            style: GoogleFonts.nunito(
                                color: SColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                        TextSpan(
                            text: Constant.madeBy,
                            style: GoogleFonts.nunito(
                                color: SColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                      ])),
              const SizedBox(height: 5),
            ])),
      )
    ]));
  }
}
