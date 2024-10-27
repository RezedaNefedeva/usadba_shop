
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/profile/view/profile.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/features/profile/widgets/widgets.dart';

import '../profile.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});


  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late DatabaseReference dbRef;

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref("users");
    SharedData.initName();
  }

  final userPhoneController = TextEditingController();
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPassController = TextEditingController();

  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signUpRequired = false;
  bool contains7length = false;

  late bool _validateName = false;
  late bool _validatePhone = false;
  late bool _validateEmail = false;
  late bool _validatePass = false;

  late List<String> errorText = [
    '',
    'Номер телефона введен не корректно',
    'Email введен не верно',
    'Номер уже используется',
    'Не надежный пароль. Придумайте пароль не менее 7 символов'
  ];


  late int indexText = 0;

  bool docExists = false;

  Future<bool> checkIfDocExists(String docId) async {
  try {
  var collectionRef = await FirebaseFirestore.instance.collection('users').doc(docId).get();
  if(collectionRef.exists){
    return docExists = true;
  } else {
    return docExists = false;
  }
  } catch (e) {
  rethrow;
  }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                          const Header(title: 'Регистрация'),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          TextFieldProfile(
                            hintText: 'Ваше имя',
                            textInputType: TextInputType.text,
                            controller: userNameController,
                            hintcolor: !_validateName ? Colors.black26 : const Color(0xff730909),
                            helperText: !_validateName ? '' : 'Поле не может быть пустым',),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          TextFieldProfile(
                            hintText: 'Номер телефона',
                            textInputType: TextInputType.number,
                            controller: userPhoneController,
                            hintcolor: !_validatePhone ? Colors.black26 : const Color(0xff730909),
                            helperText: !_validatePhone ? '' : 'Поле не может быть пустым',),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          TextFieldProfile(
                            hintText: 'Email',
                            textInputType: TextInputType.emailAddress,
                            controller: userEmailController,
                            hintcolor: !_validateEmail ? Colors.black26 : const Color(0xff730909),
                            helperText: !_validateEmail ? '' : 'Поле не может быть пустым',),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          TextFieldProfile(
                            hintText: 'Введите пароль',
                            textInputType: TextInputType.visiblePassword,
                            controller: userPassController,
                            hintcolor: !_validatePass ? Colors.black26 : const Color(0xff730909),
                            helperText: !_validatePass ? '' : 'Поле не может быть пустым',),
                          Text(
                            errorText[indexText], style: theme.textTheme.displaySmall,
                          ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      !signUpRequired
                  ?
                      InkWell(
                          onTap: () async {
                            if(userNameController.text.isEmpty){
                              setState(() {
                                _validateName = true;
                              });
                            } else if(userPhoneController.text.isEmpty){
                              setState(() {
                                _validatePhone = true;
                              });
                            } else if(userEmailController.text.isEmpty){
                              setState(() {
                                _validateEmail = true;
                              });
                            } else if(userPassController.text.isEmpty){
                              setState(() {
                                _validatePass = true;
                              });
                            } else if(userPhoneController.text.length<11 && userPhoneController.text.length>12){
                              setState(() {
                                indexText = 1;
                              });
                            } else if (!userEmailController.text.contains('@')&&!userEmailController.text.contains('.')){
                              setState(() {
                                indexText = 2;
                              });
                            } else if (userPassController.text.length<7){
                              setState(() {
                              indexText = 4;
                              });
                            } else {
                              await checkIfDocExists(userPhoneController.text);
                              if (docExists) {
                                setState(() {
                                  indexText = 3;
                                });
                              } else {
                                FirebaseFirestore.instance.collection('users').doc(
                                    userPhoneController.text).set(
                                    {'name': userNameController.text,
                                      'email': userEmailController.text,
                                      'pass': userPassController.text,
                                      'role': 'user'
                                    });
                                setState(() {
                                  if(userPhoneController.text == '89279589087' || userPhoneController.text == '89649624648'){
                                    setState(() {
                                      SharedData.setName(userNameController.text);
                                      SharedData.setPhone(userPhoneController.text);
                                      AdminProfile.userNameProfile = userNameController.text;
                                      streamController.add(8);
                                      streamControllerBottom.add(4);
                                    });
                                  } else {
                                    setState(() {
                                      SharedData.setName(userNameController.text);
                                      SharedData.setPhone(userPhoneController.text);
                                      Profile.userNameProfile = userNameController.text;
                                      streamController.add(4);
                                      streamControllerBottom.add(4);
                                    });
                                  }
                                  Profile.userNameProfile = userNameController.text;
                                  SharedData.setName(userNameController.text);
                                  SharedData.setPhone(userPhoneController.text);
                                  SharedData.setEmail(userEmailController.text);
                                  streamController.add(4);
                                  streamControllerBottom.add(4);
                                });
                              }
                            }
                          },
                          child: const buttonFirebase(widthBtn: 240, heightBtn: 48, btnText: 'Зарегистрироваться', fontSize: 16, fontFamily: 'Roboto',)
                      ) : const CircularProgressIndicator(),
                ],
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: const AuthOrReg(),)
                ]
        ),
      ),
    );
  }
}

