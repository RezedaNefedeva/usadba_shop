
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_app/models/cart_order_model/cart_order_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_app/theme/theme.dart';
import '../../cart/cart.dart';
import '../../cart/widgets/shared_order/shared_order.dart';
import '../../first_page/first_page.dart';
import '../../first_page/widgets/widgets.dart';
import '../../profile/widgets/widgets.dart';
import '../recepts.dart';
import 'widgets.dart';

class ReceptInfo extends StatefulWidget {
  ReceptInfo({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.author,
  });
  final String imageUrl;
  late String title;
  final String description;
  final String ingredients;
  final String author;

  @override
  State<ReceptInfo> createState() => _ReceptInfoState();
}

class _ReceptInfoState extends State<ReceptInfo> {

  SharedOrderDataBase db = SharedOrderPrefs();

  @override
  void initState() {
    SharedData.initName();
    super.initState();
  }

  late int counter = 1;

  bool isFound = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> loadImage(String imageUrl) async {
    try {
      // load network image example
      await precacheImage(NetworkImage(imageUrl), context);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    loadImage(widget.imageUrl);

    titleController.text = widget.title;
    ingredientController.text = widget.ingredients;
    descriptionController.text = widget.description;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 100,),
                SharedData.userName == widget.author ?
                Row(
                  children:[
                    const SizedBox(width: 20,),
                        IconButton(
                           onPressed: (){
                             showDialog(
                                 context: context,
                                 builder: (context) {
                                   return AlertDialog(
                                    title: const Text('Редактировать рецепт'),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 40.0,),
                                            Text('Ингредиенты', style: textTheme.textTheme.displayMedium,),
                                            TextFieldRecept(
                                              hintText: 'Введите название и количество ингредиентов',
                                              controller: ingredientController,
                                              hintcolor: Colors.black,
                                            ),
                                            const SizedBox(height: 40.0,),
                                            Text('Описание рецепта', style: textTheme.textTheme.displayMedium,),
                                            TextFieldRecept(
                                              hintText: 'Напишите свой рецепт',
                                              controller: descriptionController,
                                              hintcolor: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                     actions: [
                                       InkWell(
                                         onTap: (){
                                           Navigator.pop(context);
                                         },
                                         child: const buttonFirebase(
                                             widthBtn: 100,
                                             heightBtn: 40,
                                             btnText: 'Отмена',
                                             fontFamily: 'Roboto',
                                             fontSize: 12),
                                       ),
                                       InkWell(
                                         onTap: (){
                                           FirebaseFirestore.instance.collection('recepts').doc(widget.title).update({

                                             'receptIngredient' : ingredientController.text,
                                             'receptDescription' : descriptionController.text,
                                           }
                                           );
                                           Navigator.pop(context);
                                         },
                                         child: const buttonFirebase(
                                             widthBtn: 100,
                                             heightBtn: 40,
                                             btnText: 'Сохранить',
                                             fontFamily: 'Roboto',
                                             fontSize: 12),
                                       ),
                                     ],
                                   );
                                 });
                          },
                          icon: const Icon(Icons.edit)),
                        Text('Редактировать рецепт', style: textTheme.textTheme.titleMedium,)
                    ]) :
                Text('', style: textTheme.textTheme.labelSmall,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child:
                    CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: bordo(),
                              strokeWidth: 2,),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(widget.title, style:  textTheme.textTheme.labelLarge,),
                const Image(image: AssetImage('assets/line.png')),
                const SizedBox(height: 20,),
                Text('Ингредиенты:', style: textTheme.textTheme.labelLarge,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: Text(widget.ingredients, style: textTheme.textTheme.titleMedium,))
                  ],
                ),
                const SizedBox(height: 20,),
                Text('Описание рецепта:', style: textTheme.textTheme.labelLarge,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: Text(widget.description, style: textTheme.textTheme.titleMedium,))
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Автор рецепта:', style: textTheme.textTheme.labelLarge,),
                    Text(widget.author, style: textTheme.textTheme.labelLarge,),
                  ],
                ),
                SharedData.userPhone == '89279589087' || SharedData.userPhone == '89649624648'?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const SizedBox(width: 20,),
                      IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Рецепт будет удален безвозвратно.\nУдалить?'),
                                    actions: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: const buttonFirebase(
                                            widthBtn: 100,
                                            heightBtn: 40,
                                            btnText: 'Отмена',
                                            fontFamily: 'Roboto',
                                            fontSize: 12),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          FirebaseFirestore.instance.collection('recepts').doc(widget.title).delete();
                                          Navigator.pop(context);
                                          streamController.add(3);
                                        },
                                        child: const buttonFirebase(
                                            widthBtn: 100,
                                            heightBtn: 40,
                                            btnText: 'Удалить',
                                            fontFamily: 'Roboto',
                                            fontSize: 12),
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete_outline)),
                      Text('Удалить рецепт', style: textTheme.textTheme.titleMedium,)
                    ]) :
                Text('', style: textTheme.textTheme.labelSmall,),
              ],
            ),
          ]
      ),
    );
  }
}
