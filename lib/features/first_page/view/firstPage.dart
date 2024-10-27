import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/catalog/catalog.dart';
import 'package:firebase_app/features/checkoutt_page/checkoutPage.dart';
import 'package:firebase_app/features/finish_page/finish_page.dart';
import 'package:firebase_app/features/first_page/widgets/widgets.dart';
import 'package:firebase_app/features/profile/view/view.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_app/features/recepts/view/add_recept.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/features/cart/view/cart.dart';
import 'package:firebase_app/features/profile/profile.dart';
import 'package:firebase_app/features/home/view/home.dart';
import 'dart:async';

import '../../map_flutter/map_flutter.dart';
import '../../recepts/view/view.dart';

StreamController<int> streamController = StreamController<int>();
StreamController<String> streamControllerUser = StreamController<String>();

class FirstPage extends StatefulWidget {
  const FirstPage({super.key, required this.stream, required this.streamName});
  final Stream<int> stream;
  final Stream<String>streamName;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  int currentPageIndex = 0;

  @override
  void initState() {
    SharedData.initName();
    super.initState();
    widget.stream.listen((index) {
      getIndexPage(index);
    });
  }

  final pages = [
    const Home(), //0
    const Catalog(), //1
    const Cart(), //2
    const Recepts(), //3
    const Profile(), //4
    const Map_Flutter(), //5
    const Auth(), //6
    const Registration(), //7
    const AdminProfile(), //8
    const AddProduct(), //9
    const AllUsers(), //10
    const CategoryPage(), //11
    const productPage(), //12
    const checkoutPage(), //13
    const checkoutPagePickUp(), //14
    const FinishPageDelivery(), //15
    const FinishPagePickup(), //16
    const OrdersForAdmin(), //17
    const MyOrders(), //18
    const MyData(), //19
    const ReceptPage(), //20
    const AddRecept(), //21
  ];

  void profilePage (){
    if(SharedData.userName == ''){
      currentPageIndex = 6;
    } else {
      currentPageIndex = 4;
    }
  }


  void getIndexPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  void getUserName(String name) async{
    setState(() {
      // userName = name;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:<Color>[Colors.white, Colors.transparent]
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/top_card.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              )
          ),
          title: Image.asset(
            'assets/logo.png',
            height: 48,),
          centerTitle: true,
        ),
      ),

      body: pages[currentPageIndex],

      bottomNavigationBar: bottomNav(
        streamBottom: streamControllerBottom.stream,
        streamBottomUser: streamControllerBottomUser.stream,),
    );
  }

}
