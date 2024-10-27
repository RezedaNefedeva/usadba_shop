import 'package:firebase_app/features/home/widgets/card_catalog_home.dart';
import 'package:flutter/cupertino.dart';

class categoryCards extends StatefulWidget {
  const categoryCards({super.key});

  @override
  State<categoryCards> createState() => _categoryCardsState();
}

class _categoryCardsState extends State<categoryCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cardCatalogHome(category_name: 'Мясо и мясные \nполуфабрикаты', img: 'assets/pic2.png', category_index: 2,),
              cardCatalogHome(category_name: 'Колбасы \nи колбасные \nизделия', img: 'assets/pic1.png', category_index: 1,),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cardCatalogHome(category_name: 'Мясные \nделикатесы', img: 'assets/pic3.png', category_index: 3,),
              cardCatalogHome(category_name: 'Замороженные \nполуфабрикаты', img: 'assets/pic4.png', category_index: 4,),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }
}
