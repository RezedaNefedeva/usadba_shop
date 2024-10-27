import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:flutter/material.dart';

class buttonDesign extends StatefulWidget {
  const buttonDesign({super.key,
    required this.widthBtn,
    required this.heightBtn,
    required this.btnText,
    required this.fontFamily,
    required this.indexNav,
    required this.fontSize});


  final double widthBtn;
  final double heightBtn;
  final String btnText;
  final String fontFamily;
  final int indexNav;
  final double fontSize;

  @override
  State<buttonDesign> createState() => _buttonDesignState();
}

class _buttonDesignState extends State<buttonDesign> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding (
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: InkWell(
          onTap: (){
            streamController.add(widget.indexNav);
            streamControllerBottom.add(widget.indexNav);
          },
          child: Container(
              width: widget.widthBtn,
              height: widget.heightBtn,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                color: Color(0xff730909),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.btnText, style: TextStyle(color: Colors.white, fontSize: widget.fontSize, fontWeight: FontWeight.w700, fontFamily: widget.fontFamily)),
                ],
              )
          ),
        ),
    );

  }
}
