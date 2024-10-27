
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/features/profile/widgets/getImage.dart';
import 'package:firebase_app/features/profile/widgets/text_field.dart';
import 'package:firebase_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../first_page/first_page.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

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

  TextEditingController productTitleController  = TextEditingController();
  TextEditingController productDescriptionController  = TextEditingController();
  TextEditingController productWeightController  = TextEditingController();
  TextEditingController productPriceController  = TextEditingController();

  final bool _validate = false;

  bool _isLoading = false;

  String btn_text = 'Добавить';

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    String dropDowmValue = items[index];

    String imgURL = '';

    Future uploadImg(BuildContext context) async {
      setState(() {
        _isLoading = true;
      });
      String fileName = productTitleController.text;
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('products');
      Reference uploadRef = firebaseStorageRef.child(fileName);
      try{
        final uploatTask = await uploadRef.putFile(File(getImage.image!.path));
        setState(() async {
          imgURL = await (uploatTask).ref.getDownloadURL();
          FirebaseFirestore.instance.collection(items[index]).doc(
              productTitleController.text).set(
              {'title': productTitleController.text,
                'image': imgURL,
                'description': productDescriptionController.text,
                'weight': productWeightController.text,
                'price': productPriceController.text});
          setState(() {
            _isLoading = false;
            btn_text = 'Продукт добавлен';
            productTitleController.clear();
            productPriceController.clear();
            productWeightController.clear();
            productDescriptionController.clear();
          });
        });
      } catch (error){
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        body: PopScope(
          canPop: false,
          onPopInvoked: ((didpop){
            if(didpop){
              return;
            } streamController.add(8);
          }),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 120.0,),
                  Text('Выбрать категорию', style: textTheme.textTheme.displayMedium,),
                  DropdownButton(
                    value: dropDowmValue,
                      items: items.map((String items){
                        return DropdownMenuItem(
                            value: items,
                            child: Text (items));
                      }).toList(),
                      onChanged: (String? newValue){
                      setState(() {
                        chooseCategory(newValue!);
                      });
                      }),
                  const SizedBox(height: 20.0,),
                  Text('Выбрать изображение продукта', style: textTheme.textTheme.displayMedium,),
                  const SizedBox(height: 20.0,),
                  const getImage(),
                  const SizedBox(height: 20.0,),
                  Text('Название продукта', style: textTheme.textTheme.displayMedium,),
                  TextFieldProfile(hintText: '',
                      textInputType: TextInputType.text,
                      controller: productTitleController,
                      hintcolor: !_validate?Colors.black:bordo(),
                      helperText: ''),
                  const SizedBox(height: 10.0,),
                  Text('Описание продукта', style: textTheme.textTheme.displayMedium,),
                  TextFieldProfile(hintText: '',
                      textInputType: TextInputType.multiline,
                      controller: productDescriptionController,
                      hintcolor: !_validate?Colors.black:bordo(),
                      helperText: ''),
                  const SizedBox(height: 10.0,),
                  Text('За какое количество цена', style: textTheme.textTheme.displayMedium,),
                  TextFieldProfile(hintText: '',
                      textInputType: TextInputType.text,
                      controller: productWeightController,
                      hintcolor: !_validate?Colors.black:bordo(),
                      helperText: ''),
                  const SizedBox(height: 10.0,),
                  Text('Цена продукта', style: textTheme.textTheme.displayMedium,),
                  TextFieldProfile(hintText: '',
                      textInputType: TextInputType.text,
                      controller: productPriceController,
                      hintcolor: !_validate?Colors.black:bordo(),
                      helperText: ''),
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
