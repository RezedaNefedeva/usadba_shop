
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/features/first_page/view/firstPage.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  static String userNameProfile = '';

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {

  @override
  void initState() {
    SharedData.initName();
    super.initState();
  }

  String userName(){
    if(AdminProfile.userNameProfile == ''){
      return "Рады Вас видеть, ${SharedData.userName}";
    } else {
      return "Рады Вас видеть, ${AdminProfile.userNameProfile}";
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
                      streamController.add(9);
                      streamControllerBottom.add(4);
                    });
                  },
                  child: const buttonFirebase(widthBtn: 280, heightBtn: 48, btnText: 'Добавить товар', fontFamily: 'Roboto', fontSize: 16),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                InkWell(
                  onTap: (){
                    setState(() {
                      streamController.add(10);
                      streamControllerBottom.add(4);
                    });
                  },
                  child: const buttonFirebase(widthBtn: 280, heightBtn: 48, btnText: 'Все пользователи', fontFamily: 'Roboto', fontSize: 16),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                InkWell(
                  onTap: (){
                    setState(() {
                      streamController.add(17);
                      streamControllerBottom.add(4);
                    });
                  },
                  child: const buttonFirebase(widthBtn: 280, heightBtn: 48, btnText: 'Заказы', fontFamily: 'Roboto', fontSize: 16),
                ),
              ],
            ),
            TextButton(
                onPressed: (){
                  setState(() {
                    SharedData.exitUser();
                    AdminProfile.userNameProfile = '';
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