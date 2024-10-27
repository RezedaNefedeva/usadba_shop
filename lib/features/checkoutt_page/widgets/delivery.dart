
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: (){
            setState(() {
              streamController.add(13);
              streamControllerBottom.add(2);
            });
          }
          ,
          child: Text(
            'Доставка', style: TextStyle(
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
              streamController.add(14);
              streamControllerBottom.add(2);
            });
          },

          child: const Text(
            'Самовывоз', style: TextStyle(
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
