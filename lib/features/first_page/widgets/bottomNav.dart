
import 'package:firebase_app/features/first_page/first_page.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'widgets.dart';

StreamController<int> streamControllerBottom = StreamController<int>();
StreamController<String> streamControllerBottomUser = StreamController<String>();

class bottomNav extends StatefulWidget {
  const bottomNav({super.key, required this.streamBottom, required this.streamBottomUser});
  final Stream <int> streamBottom;
  final Stream <String> streamBottomUser;

  @override
  State<bottomNav> createState() => _bottomNavState();
}

class _bottomNavState extends State<bottomNav> {
  int indexNav = 0;

  String userName = '';

  @override
  void initState(){
    super.initState();
    widget.streamBottom.listen((index){
      getPageIndex(index);
    });
    widget.streamBottomUser.listen((name){
      getUserName(name);
    });
  }

  void getPageIndex(int index){
    setState(() {
      indexNav = index;
    });
  }

  void getUserName(String name){
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          image: DecorationImage (
            image: AssetImage('assets/bottom_nav.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(0);
                  indexNav = 0;
                });
              },
              child: indexNav == 0 ?
              bottomItemActive(context, 'assets/icons/red_house.png', 'Главная') :
              bottomItem(context, 'assets/icons/house.png', 'Главная')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(1);
                  indexNav = 1;
                });
              },
              child: indexNav == 1 ?
              bottomItemActive(context, 'assets/icons/red_ctalog.png', 'Каталог') :
              bottomItem(context, 'assets/icons/catalog.png', 'Каталог')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(2);
                  indexNav = 2;
                });
              },
              child: indexNav == 2 ?
              bottomItemActive(context, 'assets/icons/red_cart.png', 'Корзина') :
              bottomItem(context, 'assets/icons/shopping_cart.png', 'Корзина')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: (){
                setState(() {
                  streamController.add(3);
                  indexNav = 3;
                });
              },
              child: indexNav == 3 ?
              bottomItemActive(context, 'assets/icons/red_recept.png', 'Рецепты') :
              bottomItem(context, 'assets/icons/recept.png', 'Рецепты')
          ),
          InkResponse(
              enableFeedback: false,
              onTap: () {
                if (SharedData.userName == '') {
                  setState(() {
                    streamController.add(6);
                    indexNav = 4;
                  });
                } else if (SharedData.userName == 'Резеда' || SharedData.userName == 'Хозяин'){
                    setState(() {
                      streamController.add(8);
                      indexNav = 4;
                    });
                  } else {
                    setState(() {
                      streamController.add(4);
                      indexNav = 4;
                    });
                  }
              },
              child:indexNav == 4 ?
              bottomItemActive(context, 'assets/icons/red_user.png', 'Профиль') :
              bottomItem(context, 'assets/icons/user.png', 'Профиль')
          )
        ],
      ),
    );
  }
}
