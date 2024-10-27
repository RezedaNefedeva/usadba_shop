
import 'package:firebase_app/features/catalog/catalog.dart';
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:flutter/material.dart';

class cardCatalogHome extends StatefulWidget {
  const cardCatalogHome({super.key, required this.category_name, required this.img, required this.category_index});
  final String category_name;
  final String img;
  final int category_index;


  @override
  State<cardCatalogHome> createState() => _cardCatalogHomeState();
}

class _cardCatalogHomeState extends State<cardCatalogHome> {
  @override
  Widget build(BuildContext context) {

    checkIndex(int index){
      switch(index){
        case 1: CategoryPage.category_name = 'Колбаса и колбасные изделия';
        case 2: CategoryPage.category_name = 'Мясо и мясные полуфабрикаты';
        case 3: CategoryPage.category_name = 'Мясные деликатесы';
        case 4: CategoryPage.category_name = 'Замороженные полуфабрикаты';
      }
    }

    final textTheme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      shadowColor: Colors.black87,
      elevation: 5,
      child: SizedBox(
        width: 160,
        height: 220,
        child: InkWell(
          onTap: (){
            setState(() {
              checkIndex(widget.category_index);
              streamController.add(11);
              streamControllerBottom.add(1);
            });
          },
          child: Column(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
                  child: Image(image: AssetImage(widget.img))),
              Text(widget.category_name, style: textTheme.textTheme.bodyLarge, textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );

  }
}
