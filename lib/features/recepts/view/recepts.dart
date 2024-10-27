import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/recepts/widgets/recept_card.dart';
import 'package:firebase_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../appBar/app_bar.dart';
import '../../first_page/first_page.dart';
import '../../home/widgets/lines.dart';
import '../../profile/widgets/shared_data.dart';
import '../../profile/widgets/widgets.dart';

class Recepts extends StatefulWidget {
  const Recepts({super.key});

  @override
  State<Recepts> createState() => _ReceptsState();
}

class _ReceptsState extends State<Recepts> {
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
    final textTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        height: 184,
        child: Column(
          children: [
            SizedBox(height: 100,),
            lines(title_text: 'Рецепты'),
            SizedBox(height: 6,),
          ],
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          }
          streamController.add(0);
          streamControllerBottom.add(0);
        }),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('recepts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) {return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text ('Проверьте интернет соединение'),
            );}
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return ReceptCard(
                  receptImage: snapshot.data!.docs[index].get('receptImage'),
                  receptTitle: snapshot.data!.docs[index].get('receptTitle'),
                  receptIngredient: snapshot.data!.docs[index].get('receptIngredient'),
                  author: snapshot.data!.docs[index].get('author'),
            );
          },
        );
       }

      ),
    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(SharedData.userName == ''){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text('Добавлять рецепты могут только зарегистрированные и авторизованные пользователи.', style: textTheme.textTheme.bodyLarge,),
                    actions: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            streamController.add(6);
                            streamControllerBottom.add(4);
                            Navigator.pop(context);
                          });
                        },
                        child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Авторизация', fontFamily: 'Roboto', fontSize: 10),
                      ),
                      InkWell(
                        onTap: ()  {
                          setState(() {
                            streamController.add(7);
                            streamControllerBottom.add(4);
                            Navigator.pop(context);
                          });
                        },
                        child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Регистрация', fontFamily: 'Roboto', fontSize: 10),
                      ),
                    ],
                  );
                });
          } else {
              streamController.add(21);
              streamControllerBottom.add(3);
          }
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        label: const Text('Добавить рецепт', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Roboto'),),
        icon: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: bordo(),
      ),
   );
  }
}