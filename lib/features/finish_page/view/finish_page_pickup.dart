
import 'package:flutter/material.dart';

import '../widgets/white_btn.dart';

class FinishPagePickup extends StatefulWidget {
  const FinishPagePickup({super.key});

  @override
  State<FinishPagePickup> createState() => _FinishPagePickupState();
}

class _FinishPagePickupState extends State<FinishPagePickup> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 280,
              height: 280,
              child: Image(image: AssetImage('assets/finish_pic.png'), fit: BoxFit.fill,),),
            const SizedBox(height: 40,),
            Text('Спасибо за Ваш заказ!', style: textTheme.textTheme.displayLarge,),
            const SizedBox(height: 10,),
            Flexible(
                child: Text('Ждем Вас по адресу ул. Крупской д.3а\nмагазин "Усадьба мясника"\nВторник - пятница с 10.00 до 19.00\nСуббота - воскресенье с 10.00 до 18.00\nПонедельник выходной',
                  style: textTheme.textTheme.titleMedium, textAlign: TextAlign.center,)),
            const SizedBox(height: 40,),
            const whiteButtonDesign(widthBtn: 300, heightBtn: 60, btnText: 'Продолжить покупки', fontFamily: 'OrelegaOne', indexNav: 1, fontSize: 20),
          ],
        ),
      ),
    );
  }
}
