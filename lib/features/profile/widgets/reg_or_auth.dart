
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';

class RegOrAuth extends StatefulWidget {
  const RegOrAuth({super.key});

  @override
  State<RegOrAuth> createState() => _RegOrAuthState();
}

class _RegOrAuthState extends State<RegOrAuth> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: (){
            setState(() {
              streamController.add(6);
              streamControllerBottom.add(4);
            });
          }
          ,
          child: Text(
            'Авторизация', style: TextStyle(
              fontFamily: 'OrelegaOne',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: bordo(),
              decoration: TextDecoration.underline),
          ),
        ),
        TextButton(
          onPressed: (){
            setState(() {
              streamController.add(7);
              streamControllerBottom.add(4);
            });
          },

          child: const Text(
            'Регистрация', style: TextStyle(
              fontFamily: 'OrelegaOne',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black),

          ),
        ),
      ],
    );
  }
}
