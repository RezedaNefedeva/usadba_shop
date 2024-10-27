import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/catalog/widgets/product_card.dart';
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  static String category_name = '';

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List category = [];

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    initFirebase();
    super.initState();
    setState(() {
      CategoryPage.category_name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(CategoryPage.category_name, style: textTheme.textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: ((didpop){
          if(didpop){
          return;
          } streamController.add(1);
    }),
        child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(CategoryPage.category_name).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) {return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text ('Проверьте интернет соединение'),
          );}
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
                return productCard(
                    imageUrl: snapshot.data!.docs[index].get('image'),
                    title: snapshot.data!.docs[index].get('title'),
                    weight: snapshot.data!.docs[index].get('weight'),
                    price: snapshot.data!.docs[index].get('price'),);
              }
          );
        },
      ),

    ),
    );
  }
}