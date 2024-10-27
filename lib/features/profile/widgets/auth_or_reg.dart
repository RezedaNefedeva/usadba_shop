
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';

class AuthOrReg extends StatefulWidget {
  const AuthOrReg({super.key});

  @override
  State<AuthOrReg> createState() => _AuthOrRegState();
}

class _AuthOrRegState extends State<AuthOrReg> {
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
          child: const Text(
            'Авторизация', style: TextStyle(
              fontFamily: 'OrelegaOne',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: (){
              setState(() {
              streamController.add(7);
              streamControllerBottom.add(4);
              });
            },

          child: Text(
            'Регистрация', style: TextStyle(
              fontFamily: 'OrelegaOne',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: bordo(),
              decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
