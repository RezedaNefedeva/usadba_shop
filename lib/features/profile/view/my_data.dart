
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/profile/view/view.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';
import '../../first_page/first_page.dart';

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  TextEditingController nameChangeController = TextEditingController();
  TextEditingController emailChangeController = TextEditingController();
  TextEditingController passChangeController = TextEditingController();
  TextEditingController adressChangeController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Мои данные', style: textTheme.textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: ((didpop){
            if(didpop){
              return;
            } streamController.add(4);
          }),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12,),
                    Text('Имя', style: textTheme.textTheme.titleMedium,),
                    const SizedBox(height: 6,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(SharedData.userName, style: textTheme.textTheme.displayMedium,),
                          IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: const Text('Изменить имя'),
                                        content: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                            nameChangeController.text = value;
                                            });
                                          },
                                          controller: nameChangeController,
                                      decoration:
                                      const InputDecoration(hintText: 'Введите новое имя'),
                                        ),
                                        actions: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Отмена', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                FirebaseFirestore.instance.collection('users').doc(SharedData.userPhone).update({
                                                  'name' : nameChangeController.text
                                                }
                                                );
                                                SharedData.setName(nameChangeController.text);
                                                SharedData.userName = nameChangeController.text;
                                                Profile.userNameProfile = nameChangeController.text;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Изменить', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                        ],
                                      );
                                    }
                                );
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text('Номер телефона', style: textTheme.textTheme.titleMedium,),
                    const SizedBox(height: 6,),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                        ),
                        child: Text(SharedData.userPhone, style: textTheme.textTheme.displayMedium,)),
                    const SizedBox(height: 20,),
                    Text('Email', style: textTheme.textTheme.titleMedium,),
                    const SizedBox(height: 6,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(SharedData.userEmail, style: textTheme.textTheme.displayMedium,),
                          IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text('Изменить email'),
                                        content: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              emailChangeController.text = value;
                                            });
                                          },
                                          controller: emailChangeController,
                                          decoration:
                                          const InputDecoration(hintText: 'Введите новый email'),
                                        ),
                                        actions: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Отмена', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                FirebaseFirestore.instance.collection('users').doc(SharedData.userPhone).update({
                                                  'email' : emailChangeController.text
                                                }
                                                );
                                                SharedData.setEmail(emailChangeController.text);
                                                SharedData.userEmail = emailChangeController.text;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Изменить', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                        ],
                                      );
                                    }
                                );
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text('Адрес доставки', style: textTheme.textTheme.titleMedium,),
                    const SizedBox(height: 6,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SharedData.adressList == '' ?
                          Flexible(child: Text ('Добавить адрес', style: textTheme.textTheme.labelSmall))
                              :
                          Text(SharedData.adressList, style: textTheme.textTheme.displayMedium,),
                
                          SharedData.adressList == '' ?
                          IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text('Добавить адрес'),
                                        content: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              adressChangeController.text = value;
                                            });
                                          },
                                          controller: adressChangeController,
                                          decoration:
                                          const InputDecoration(hintText: 'Введите адрес'),
                                        ),
                                        actions: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Отмена', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                SharedData.setAdressList(adressChangeController.text);
                                                SharedData.adressList = adressChangeController.text;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Добавить', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                        ],
                                      );
                                    }
                                );
                              },
                              icon: const Icon(Icons.add))
                              :
                          IconButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text('Изменить адрес'),
                                        content: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              adressChangeController.text = value;
                                            });
                                          },
                                          controller: adressChangeController,
                                          decoration:
                                          const InputDecoration(hintText: 'Введите новый адрес'),
                                        ),
                                        actions: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Отмена', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                SharedData.setAdressList(adressChangeController.text);
                                                SharedData.adressList = adressChangeController.text;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Изменить', fontFamily: 'Roboto', fontSize: 10),
                                          ),
                                        ],
                                      );
                                    }
                                );
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                    ),
                    const SizedBox(height: 90,),
                    TextButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: const Text('Сменить пароль'),
                                content: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      passChangeController.text = value;
                                    });
                                  },
                                  controller: passChangeController,
                                  decoration:
                                  const InputDecoration(hintText: 'Введите новый пароль'),
                                ),
                                actions: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Отмена', fontFamily: 'Roboto', fontSize: 10),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        FirebaseFirestore.instance.collection('users').doc(SharedData.userPhone).update({
                                          'pass' : passChangeController.text
                                        }
                                        );
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Изменить', fontFamily: 'Roboto', fontSize: 10),
                                  ),
                                ],
                              );
                            }
                        );
                      },
                      child: Text('Сменить пароль', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: bordo(),
                          decoration: TextDecoration.underline),
                      ),
                    ),
                
                
                  ],
                ),
              ),
            ),
          )
      );
  }
}