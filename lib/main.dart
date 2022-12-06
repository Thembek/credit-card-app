import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

import 'package:credit_card_animation/model/card_module.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "ocr-a",
      ),
      home: CreditCard(),
    );
  }
}

class CreditCard extends StatefulWidget {
  CreditCard({ Key? key }) : super(key: key);

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> with SingleTickerProviderStateMixin {
  bool _confirm = false;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
  }

  int _selectedIndex = 0;

  List<String> _tabs = ["Home", "Finance", "Cards", "Crypto", "History"];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            padding: EdgeInsets.only(top: 60, right: 25, left: 20),
            decoration: BoxDecoration(
              color: Color(0xFF0B258A),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.4),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    Text(
                      "Select Card",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white.withOpacity(.5)
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/IMG_5706.JPG"),
                        )
                      ),
                    ),
                  ],
                ),
              ],
            ),  
          ),
        ],
      ),
    );
  }
}