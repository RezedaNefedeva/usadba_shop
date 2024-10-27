
import 'package:firebase_app/features/finish_page/widgets/white_btn.dart';
import 'package:flutter/material.dart';

class FinishPageDelivery extends StatefulWidget {
  const FinishPageDelivery({super.key});

  @override
  State<FinishPageDelivery> createState() => _FinishPageDeliveryState();
}

class _FinishPageDeliveryState extends State<FinishPageDelivery> {
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
                child: Text('В ближайшее время мы свяжемся с Вами по указанному телефону для уточнения суммы и деталей заказа',
                style: textTheme.textTheme.titleMedium, textAlign: TextAlign.center,)),
            const SizedBox(height: 40,),
            const whiteButtonDesign(widthBtn: 300, heightBtn: 60, btnText: 'Продолжить покупки', fontFamily: 'OrelegaOne', indexNav: 1, fontSize: 20),
          ],
        ),
      ),
    );
  }
}
