import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class buttonFirebase extends StatefulWidget {
  const buttonFirebase({super.key,
    required this.widthBtn,
    required this.heightBtn,
    required this.btnText,
    required this.fontFamily,
    required this.fontSize,
  });


  final double widthBtn;
  final double heightBtn;
  final String btnText;
  final String fontFamily;
  final double fontSize;


  @override
  State<buttonFirebase> createState() => _buttonFirebaseState();
}

class _buttonFirebaseState extends State<buttonFirebase> {

  void initFirebase()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding (
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      );
  }
}
