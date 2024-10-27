
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/catalog/widgets/product_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../first_page/first_page.dart';
import 'category_page.dart';

class productPage extends StatefulWidget {
  const productPage({super.key});

  static String product_title = '';

  static bool backFrom = false;

  @override
  State<productPage> createState() => _productPageState();
}

class _productPageState extends State<productPage> {

  String description = '';
  String weight = '';
  String price = '';
  String imageUrl = '';

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    getInfo();
    initFirebase();
    super.initState();
    setState(() {
      productPage.product_title;
      CategoryPage.category_name;
    });
  }

  Future getInfo() async {
    try {
      var collectionRef = await FirebaseFirestore.instance.collection(CategoryPage.category_name).doc(productPage.product_title).get();
      setState(() {
        description = collectionRef['description'];
        imageUrl = collectionRef['image'];
        weight = collectionRef['weight'];
        price = collectionRef['price'];
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
          canPop: false,
          onPopInvoked: ((didpop){
            if(didpop){
              return;
            } else if(!productPage.backFrom){
              streamController.add(11);
            } else if(productPage.backFrom){
              streamController.add(2);
            }
          }),
          child: productInfo(
                  imageUrl: imageUrl,
                  title: productPage.product_title,
                  description: description,
                  weight: weight,
                  price: price),
      ),
    );
  }
}

