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

                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hi, Abbulerhman",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Flash(
                  child: BlurryContainer(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Balance",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$ 543, 933.33",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.currency_bitcoin,
                                    color: Color(0xFF0B258A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    blur: 50,
                    width: 300,
                    height: 100,
                    elevation: 0,
                    color: Colors.grey.withOpacity(.4),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ],
            ),  
          ),

          Spacer(),
          Container(
            height: 50,
            child: ListView.builder(
              itemCount: _tabs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return SlideInLeft(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Text(
                        _tabs[index],
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: index == _selectedIndex
                              ? Color(0xFF0B258A)
                              : Color(0xFF0B258A).withOpacity(.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              })  
            ),
          ),

          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 55,
              child: SlideInUp(
                child: CardSlider(
                  height: MediaQuery.of(context).size.height * 6,
                  confirm: (confirm) {
                    _confirm = confirm;
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardSlider extends StatefulWidget {
  final double height;
  final Function(bool) confirm;
  const CardSlider({
    Key? key,
    required this.height,
    required this.confirm,
  }) : super(key: key);

  @override
  State<CardSlider> createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  late double positionY_line1;
  late double positionY_line2;
  late List<CardInfo> _cardInfoList;
  late double _middleAreaHeight;
  late double _outsiteCardInterval;
  late double scrollOffsetY;

  @override
  void initState() {
    super.initState();
    positionY_line1 = widget.height * 0.1;
    positionY_line2 = positionY_line1 + 200;
    widget.confirm(false);

    _middleAreaHeight = positionY_line2 - positionY_line1;
    _outsiteCardInterval = 30.0;
    scrollOffsetY = 0.0;

    _cardInfoList = [
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 234, 94, 190),
        rightColor: Color.fromARGB(255, 224, 63, 92),
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 10, 10, 10),
        rightColor: Color.fromARGB(255, 10, 10, 10),
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Colors.pinkAccent,
        rightColor: Colors.pinkAccent,
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color(0xFF0B258A),
        rightColor: Color.fromARGB(255, 49, 69, 147),
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Colors.red,
        rightColor: Colors.redAccent,
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 229, 190, 35),
        rightColor: Colors.redAccent, 
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 85, 137, 234),
        rightColor: Color.fromARGB(255, 10, 10, 10),
      ),
      CardInfo(
        userName: "ABDUL REHMAN",
        leftColor: Color.fromARGB(255, 171, 51, 75),
        rightColor: Color.fromARGB(55, 224, 63, 92),
      ),
    ];

    for (int i = 0; i < _cardInfoList.length; i++) {
      CardInfo cardInfo = _cardInfoList[i];
      if(i == 0) {
        cardInfo.positionY = positionY_line1;
        cardInfo.opacity = 1.0;
        cardInfo.rotate - 1.0;
        cardInfo.scale = 1.0;
      } else {
        cardInfo.positionY = positionY_line2 + (i - 1) * 30;
        cardInfo.opacity = 0.7 - (i - 1) * 0.1;
        cardInfo.rotate = -60;
        cardInfo.scale = 0.9;
      }
    }

    _cardInfoList = _cardInfoList.reversed.toList();
  }

  _cardBuild() {
    List widgetList = [];

    for(CardInfo cardInfo in _cardInfoList) {
      widgetList.add(
        Positioned(
          top: cardInfo.positionY,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(pi / 180 * cardInfo.rotate)
              ..scale(cardInfo.scale),
            alignment: Alignment.topCenter,
            child: Opacity(
              opacity: cardInfo.opacity,
              child: Container(
                width: 300,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 10,
                      offset: Offset(5, 10),
                    ),
                  ],
                  color: Colors.red,
                  gradient: LinearGradient(
                    colors: [cardInfo.leftColor, cardInfo.rightColor],
                  ),
                ),

                child: Stack(
                  children: [
                    Positioned(
                      top: 130,
                      left: 20,
                      child: Text(
                        "5434 3443 654453",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.5,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 30,
                      right: 70,
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset(
                          "assets/globe.png",
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      top: 70,
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 80,
                            child: Image.asset(
                              "assets/sim.png",
                              fit: BoxFit.fill,
                            ),
                          ),

                          Container(
                            height: 20,
                            width: 25,
                            child: Image.asset(
                              "assets/signal.png",
                              fit: BoxFit.contain,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        height: 80,
                        width: 80,
                        child: Image.asset("assets/mastercardLogo.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ));
    }
    return widgetList;
  }

  void _updateCardPosition(double offsetY)  {
    scrollOffsetY += offsetY;

    void updatePosition(CardInfo cardInfo, double firstCardAreaIdx, int index) {
      double currentCardAreaIdx = firstCardAreaIdx + index;
      if(currentCardAreaIdx < 0) {
        cardInfo.positionY = positionY_line1 + currentCardAreaIdx * 5;

        cardInfo.scale = 1.0 - 0.2 / 10 * (positionY_line1 - cardInfo.positionY);

        if(cardInfo.scale < 0.8) cardInfo.scale = 0.8;
        if(cardInfo.scale > 1) cardInfo.scale = 1.0;


      }
    }
  }
}

