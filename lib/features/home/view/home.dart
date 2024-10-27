import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/home/widgets/contacts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../recepts/widgets/recept_card.dart';
import '../widgets/recept_card.dart';
import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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

    return  ListView(
              children: const [
                lines(title_text: 'О нас'),
                aboutUs(),
                lines(title_text: 'Каталог'),
                categoryCards(),
                buttonDesign(widthBtn: 200, heightBtn: 48, btnText: 'В каталог', indexNav: 1, fontSize: 20, fontFamily: 'Roboto',),
                SizedBox(height: 20,),
                lines(title_text: 'Рецепты'),
                SizedBox(height: 10,),
                receptScroll(),
                SizedBox(height: 40,),
                lines(title_text: 'Контакты'),
                contact()
              ],
    );
  }
}
