
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';

class Pickup extends StatefulWidget {
  const Pickup({super.key});

  @override
  State<Pickup> createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
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
          child: const Text(
            'Доставка', style: TextStyle(
              fontFamily: 'OrelegaOne',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,),
          ),
        ),
        TextButton(
          onPressed: (){
            setState(() {
              streamController.add(141);
              streamControllerBottom.add(2);
            });
          },

          child: Text(
            'Самовывоз', style: TextStyle(
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
