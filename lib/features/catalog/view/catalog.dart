import 'package:firebase_app/features/home/widgets/lines.dart';
import 'package:firebase_app/features/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/widgets.dart';



class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {


  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    initFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children:  const [
            SizedBox(height: 120,),
            lines(title_text: 'Каталог'),
            SizedBox(height: 20,),
            const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
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
          ],
        ),
      );
  }
}
