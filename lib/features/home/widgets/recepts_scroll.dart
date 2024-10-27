
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/home/widgets/recept_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class receptScroll extends StatefulWidget {
  const receptScroll({super.key});

  @override
  State<receptScroll> createState() => _receptScrollState();
}

class _receptScrollState extends State<receptScroll> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    initFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('recepts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) {return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text ('Проверьте интернет соединение'),
          );}
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index){
                return receptCard(
                    img: snapshot.data!.docs[index].get('receptImage'),
                    recept_name: snapshot.data!.docs[index].get('receptTitle'));
              }
          );
        },
      ),
    );
  }
}
