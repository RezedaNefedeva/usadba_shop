
import 'package:flutter/material.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Column(
      children: [
         const Padding(padding: EdgeInsets.only(top: 20)),
         const Card(
           elevation: 5,
           child: Image(
             image: AssetImage ('assets/main_pic.png'),
             width: 300,
             height: 300,),
         ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Магазин "Усадьба мясника" это магазин колбас, мясных деликатесов, замороженных и мясных полуфабрикатов собственного производства. '
              'В нашем приложении Вы можете сделать заказ на доставку или предзаказ для самовывоза на весь ассортимент нашего магазина.'
              '\nТак как весь ассортимент делается нами вручную, мы не можем сделать фиксированнный вес на некоторые позиции, поэтому в каталоге указаны примерные цены за палку колбасы. При оформлении заказа Вы увидите примерную итоговую сумму. Точную сумму мы Вам сообщим по указанному номеру телефона после сборки заказа.'
              '\nДоставка по городу Сибай бесплатная. \nОплатить заказ можно только при получении.', style: textTheme.textTheme.titleMedium,),
        ),
        const Padding(padding: EdgeInsets.only(top: 40)),
      ],
    );
  }
}
