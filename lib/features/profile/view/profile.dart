
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/home/widgets/button-design.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/features/first_page/view/firstPage.dart';

import '../widgets/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  static String userNameProfile = '';
  static String userPhone = '';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    SharedData.initName();
    Profile.userPhone = SharedData.userPhone;
    super.initState();
    getToken();
  }

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          saveToken(token!);
        }
    );
  }

  void saveToken(String token) async{
    await FirebaseFirestore.instance.collection('userTokens').doc(SharedData.userPhone).set({
      'token' : token,
    });

  }

  String userName(){
    if(Profile.userNameProfile == ''){
      return "Рады Вас видеть, ${SharedData.userName}";
    } else {
      return "Рады Вас видеть, ${Profile.userNameProfile}";
    }
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(top: 80)),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  userName(),
                  style: textTheme.textTheme.labelLarge
              ),
          ]
          ),

          Column(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    streamController.add(18);
                    streamControllerBottom.add(4);
                  });
                },
                child: const buttonFirebase(widthBtn: 280, heightBtn: 48, btnText: 'Мои заказы', fontFamily: 'Roboto', fontSize: 16),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              InkWell(
                onTap: (){
                  setState(() {
                    streamController.add(19);
                    streamControllerBottom.add(4);
                  });
                },
                child: const buttonFirebase(widthBtn: 280, heightBtn: 48, btnText: 'Мои данные', fontFamily: 'Roboto', fontSize: 16),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
            ],
          ),
          TextButton(
              onPressed: (){
                setState(() {
                  SharedData.exitUser();
                  streamController.add(6);
                  streamControllerBottom.add(4);
                });
              },
              child: Text('Выход', style: textTheme.textTheme.displaySmall,))
        ]
        ),
      );
  }
}