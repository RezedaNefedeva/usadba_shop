
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/appBar/app_bar.dart';
import 'package:firebase_app/features/home/widgets/lines.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/features/profile/widgets/getImage.dart';
import 'package:firebase_app/features/profile/widgets/text_field.dart';
import 'package:firebase_app/features/recepts/widgets/text_field_recept.dart';
import 'package:firebase_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../first_page/first_page.dart';
import '../../profile/widgets/shared_data.dart';

class AddRecept extends StatefulWidget {
  const AddRecept({super.key});

  @override
  State<AddRecept> createState() => _AddReceptState();
}

class _AddReceptState extends State<AddRecept> {

  var items = [
    'Колбаса и колбасные изделия',
    'Мясо и мясные полуфабрикаты',
    'Мясные деликатесы',
    'Замороженные полуфабрикаты'
  ];

  int index = 0;

  chooseCategory(String value){
    switch(value){
      case 'Колбаса и колбасные изделия': index = 0;
      case 'Мясо и мясные полуфабрикаты': index = 1;
      case 'Мясные деликатесы': index = 2;
      case 'Замороженные полуфабрикаты': index = 3;
    }
  }

  TextEditingController receptTitleController  = TextEditingController();
  TextEditingController receptIngredientController  = TextEditingController();
  TextEditingController receptDescriptionController  = TextEditingController();

  final bool _validate = false;

  bool _isLoading = false;

  String btn_text = 'Добавить';

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    String imgURL = '';

    Future uploadImg(BuildContext context) async {
      setState(() {
        _isLoading = true;
      });
      String fileName = receptTitleController.text;
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('recepts');
      Reference uploadRef = firebaseStorageRef.child(fileName);
      try{
        final uploatTask = await uploadRef.putFile(File(getImage.image!.path));
        setState(() async {
          imgURL = await (uploatTask).ref.getDownloadURL();
          FirebaseFirestore.instance.collection('recepts').doc(
              receptTitleController.text).set(
              {'receptTitle': receptTitleController.text,
                'receptImage': imgURL,
                'receptIngredient': receptIngredientController.text,
                'receptDescription': receptDescriptionController.text,
                'author' : SharedData.userName
              });
          setState(() {
            _isLoading = false;
            btn_text = 'Рецепт добавлен';
            receptTitleController.clear();
            receptIngredientController.clear();
            receptDescriptionController.clear();
          });
        });
      } catch (error){
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        height: 184,
        child: Column(
          children: [
            SizedBox(height: 100,),
            lines(title_text: 'Добавить рецепт'),
            SizedBox(height: 6,),
          ],
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: PopScope(
          canPop: false,
          onPopInvoked: ((didpop){
            if(didpop){
              return;
            } streamController.add(3);
          }),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0,),
                Text('Выбрать изображение рецепта', style: textTheme.textTheme.displayMedium,),
                const getImage(),
                const SizedBox(height: 20.0,),
                Text('Название рецепта', style: textTheme.textTheme.displayMedium,),
                TextFieldProfile(
                    hintText: 'Введите название рецепта',
                    textInputType: TextInputType.text,
                    controller: receptTitleController,
                    hintcolor: !_validate?Colors.black:bordo(),
                    helperText: ''),
                const SizedBox(height: 20.0,),
                Text('Ингредиенты', style: textTheme.textTheme.displayMedium,),
                TextFieldRecept(
                    hintText: 'Введите название и количество ингредиентов',
                    controller: receptIngredientController,
                    hintcolor: !_validate?Colors.black:bordo(),
                ),
                const SizedBox(height: 40.0,),
                Text('Описание рецепта', style: textTheme.textTheme.displayMedium,),
                TextFieldRecept(
                    hintText: 'Напишите свой рецепт',
                    controller: receptDescriptionController,
                    hintcolor: !_validate?Colors.black:bordo(),
                ),
                const SizedBox(height: 20.0,),
                InkWell(
                  onTap: () async {
                    await uploadImg(context);
                  },
                  child: _isLoading ?
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      color: bordo(),
                      strokeWidth: 3,
                    ),
                  ) :
                  buttonFirebase(widthBtn: 280, heightBtn: 48, btnText: btn_text, fontFamily: 'Roboto', fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}