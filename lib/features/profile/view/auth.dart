import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';
import '../profile.dart';
import '../widgets/widgets.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  late DatabaseReference dbRef;

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    SharedData.initName();
  }

  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  late bool _validateAuth = false;

  late List<String> errorText = [
    '',
    'Номер телефона введен не корректно',
    'На этом номере телефона нет зарегистрированных пользователей. Зарегистрируйтесь или введите другой номер телефона',
    'Пароль не верный'
  ];


  late int indexText = 0;

  late String userName = '';

  bool docExists = false;

  bool passRight = false;

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = await FirebaseFirestore.instance.collection('users').doc(docId).get();
      if(collectionRef.exists){
        if(collectionRef['pass'] == userPassController.text){
          passRight = true;
          userName = collectionRef['name'];
        } else {
          passRight = false;
        }
        return docExists = true;
      } else {
        return docExists = false;
      }
    } catch (e) {
      rethrow;
    }
  }

  void _passRight(){
    if(userPhoneController.text == '89279589087' || userPhoneController.text == '89649624648'){
      setState(() {
        SharedData.setName(userName);
        SharedData.setPhone(userPhoneController.text);
        AdminProfile.userNameProfile = userName;
        streamController.add(8);
        streamControllerBottom.add(4);
        streamControllerUser.add(userName);
        streamControllerBottomUser.add(userName);
      });
    } else {
      setState(() {
        SharedData.setName(userName);
        SharedData.setPhone(userPhoneController.text);
        Profile.userNameProfile = userName;
        streamController.add(4);
        streamControllerBottom.add(4);
        streamControllerUser.add(userName);
        streamControllerBottomUser.add(userName);
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
            height: MediaQuery.of(context).size.height - 80,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  children: [
                    const Header(title: 'Авторизация'),
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    TextFieldProfile(
                        hintText: 'Номер телефона',
                        textInputType: TextInputType.number,
                        controller: userPhoneController,
                        hintcolor: !_validateAuth ? Colors.black26 : bordo(),
                        helperText: !_validateAuth ? '' : 'Поле не может быть пустым'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    TextFieldProfile(
                        hintText: 'Пароль',
                        textInputType: TextInputType.visiblePassword,
                        controller: userPassController,
                        hintcolor: !_validateAuth ? Colors.black26 : bordo(),
                        helperText: !_validateAuth ? '' :  'Поле не может быть пустым'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: const Text('Смена пароля'),
                                    content: Container(
                                      height: 140,
                                      child: Column(
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                userPhoneController.text = value;
                                              });
                                            },
                                            controller: userPhoneController,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                            const InputDecoration(hintText: 'Номер телефона'),
                                          ),
                                          const SizedBox(height: 6,),
                                          TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                newPassController.text = value;
                                              });
                                            },
                                            controller: newPassController,
                                            decoration:
                                            const InputDecoration(hintText: 'Новый пароль'),
                                          ),
                                        ],
                                      ),
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
                                        onTap: () async {
                                              await checkIfDocExists(userPhoneController.text);
                                              if (docExists) {
                                                setState(() {
                                                  FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(
                                                      userPhoneController.text)
                                                      .update({
                                                    'pass': newPassController.text
                                                  }
                                                  );
                                                  Navigator.pop(context);
                                                });
                                              }  else {
                                                setState(() {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context){
                                                        return AlertDialog(
                                                          title: const Text('Номер телефона не зарегистрирован. Перейти на страницу регистрации?.', style: TextStyle(fontSize: 12),),
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
                                                              onTap: ()  {
                                                                setState(() {
                                                                  streamController.add(7);
                                                                  Navigator.pop(context);
                                                                  Navigator.pop(context);
                                                                });
                                                              },
                                                              child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Перейти', fontFamily: 'Roboto', fontSize: 10),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                  );
                                                });
                                              }

                                        },
                                        child: const buttonFirebase(widthBtn: 100, heightBtn: 40, btnText: 'Изменить', fontFamily: 'Roboto', fontSize: 10),
                                      ),
                                    ],
                                  );
                                }
                            );
                          },
                          child: Text('Забыли пароль', style: text_theme.textTheme.titleSmall,)),]
                    ),
                    Text(
                      errorText[indexText], style: theme.textTheme.displaySmall,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    InkWell(
                      onTap: () async {
                        if(userPhoneController.text.isEmpty || userPassController.text.isEmpty){
                          setState(() {
                            _validateAuth = true;
                          });
                        } else if (userPhoneController.text.length<11 || userPhoneController.text.length>12){
                          setState(() {
                            indexText = 1;
                          });
                        } else {
                          await checkIfDocExists(userPhoneController.text);
                          if (docExists) {
                            if(passRight){
                              _passRight();
                            } else {
                              setState(() {
                                indexText = 3;
                              });
                             }
                          }  else {
                          setState(() {
                            indexText = 2;
                          });
                        }
                        }
                      },
                      child: const buttonFirebase(widthBtn: 240, heightBtn: 48, btnText: 'Авторизоваться', fontFamily: 'Roboto', fontSize: 16),
                    ),
                  ],
                ),
            ),
            ),
            const Positioned(
              bottom: 0,
                right: 0,
                left: 0,
                child: const RegOrAuth(),)
        ]
        ),
      ),
    );
  }
}
