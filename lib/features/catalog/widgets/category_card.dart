
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:flutter/material.dart';

import '../catalog.dart';

class categoryCard extends StatefulWidget {
  const categoryCard({super.key, required this.category_name, required this.img});
  final String category_name;
  final String img;

  @override
  State<categoryCard> createState() => _categoryCardState();
}

class _categoryCardState extends State<categoryCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: Colors.black87,
        elevation: 5,
        child: SizedBox(
          width: 300,
          height: 150,
          child: InkWell(
            onTap: (){
              setState(() {
                CategoryPage.category_name = widget.category_name;
                streamController.add(11);
                streamControllerBottom.add(1);
              });
            },
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                    width: 200,
                    height: 100,
                    child: Image(image: AssetImage(widget.img), fit: BoxFit.fill,)),
                Text(widget.category_name, style: textTheme.textTheme.bodyLarge, textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      );

  }
}