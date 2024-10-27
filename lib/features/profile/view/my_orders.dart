
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/profile/view/view.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/theme/theme.dart';
import '../../first_page/first_page.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  List my_orders = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Мои заказы', style: textTheme.textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          } streamController.add(4);
        }),
        child:
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(SharedData.userPhone).collection('orders').orderBy('date', descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData) return const Text ('Вы пока ничего не заказывали');
              if (snapshot.hasError) {
                return const Text('Что-то пошло не так');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Загружается");
            }
            return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${index + 1}'),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Text('ДАТА:   ${snapshot.data!.docs[index]['date']}',
                                style: textTheme.textTheme.titleMedium,),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Flexible(
                                child: Text(
                                  'ЗАКАЗ:   ${snapshot.data!.docs[index]['order_list']}',
                                  style: textTheme.textTheme.titleMedium,)),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Text('ПРЕДВАРИТЕЛЬНАЯ СУММА:   ${snapshot.data!.docs[index]['total']}',
                              style: textTheme.textTheme.titleMedium,),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Text('АДРЕС:   ${snapshot.data!.docs[index]['user_adress']}',
                              style: textTheme.textTheme.titleMedium,),
                          ],
                        ),


                      ),
                    );
                  });
                }
            )
        ),
      );
  }
}