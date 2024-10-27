
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/appBar/app_bar.dart';
import 'package:firebase_app/features/checkoutt_page/widgets/delivery.dart';
import 'package:firebase_app/features/checkoutt_page/widgets/text_form_fieald_auto.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_app/features/profile/widgets/text_field.dart';
import 'package:firebase_app/local_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_app/theme/theme.dart';
import '../../cart/cart.dart';
import '../../first_page/first_page.dart';
import '../../first_page/widgets/widgets.dart';
import '../../home/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_app/push_notification.dart';

class checkoutPage extends StatefulWidget {
  const checkoutPage({super.key});

  @override
  State<checkoutPage> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<checkoutPage> {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  String mtoken = '';
  String m2token = '';



  @override
  void initState() {
    super.initState();
    final messaging = FirebaseMessaging.instance;
    LocalNotificationServices.initialize(flutterLocalNotificationsPlugin);
    requestPermission();
    adminToken();
    FirebaseMessaging.instance.getInitialMessage();
  }

  void requestPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert:  false,
      provisional: false,
      sound: true,
    );
  }

  void  adminToken() async {
    var adminToken = await FirebaseFirestore.instance.collection('userTokens').doc('89279589087').get();
    if(adminToken.exists){
      mtoken = adminToken['token'];
    }

    var admin2Token = await FirebaseFirestore.instance.collection('userTokens').doc('89649624648').get();
    if(admin2Token.exists){
      m2token = admin2Token['token'];
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool _validate = false;

  bool isCheckedCard = false;
  bool isCheckedCash = false;

  List<String> payment = [
    'Оплата наличными',
    'Оплата картой',
    'Не выбран способ оплаты'
  ];

  String _payment = '';

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  String date = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    // _payment = payment[2];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        height: 184,
        child: Column(
          children: [
            SizedBox(height: 100,),
            lines(title_text: 'Оформление заказа'),
            SizedBox(height: 6,),
          ],
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: ((didpop){
          if(didpop){
            return;
          }
            streamController.add(2);
        }),
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const Delivery(),
                  const SizedBox(height: 10,),
                  SharedData.userName != '' ?
                  TextFieldAuto(
                      hintText: 'Ваше имя',
                      textInputType: TextInputType.text,
                      controller: nameController,
                      hintcolor: !_validate ? Colors.black26 : bordo(),
                      helperText: !_validate ? '' : 'Поле не может быть пустым',
                      userData: SharedData.userName,
                      userDataText: AutofillHints.name)
                  : TextFieldProfile(
                      hintText: 'Ваше имя',
                      textInputType: TextInputType.text,
                      controller: nameController,
                      hintcolor: !_validate ? Colors.black26 : bordo(),
                      helperText: !_validate ? '' : 'Поле не может быть пустым'),
                  SharedData.userName != '' ?
                  TextFieldAuto(
                      hintText: 'Номер телефона',
                      textInputType: TextInputType.number,
                      controller: phoneController,
                      hintcolor: !_validate ? Colors.black26 : bordo(),
                      helperText: !_validate ? '' : 'Поле не может быть пустым',
                      userData: SharedData.userPhone,
                      userDataText: AutofillHints.telephoneNumber)
                  : TextFieldProfile(
                      hintText: 'Номер телефона',
                      textInputType: TextInputType.number,
                      controller: phoneController,
                      hintcolor: !_validate ? Colors.black26 : bordo(),
                      helperText: !_validate ? '' : 'Поле не может быть пустым'),
                  SharedData.userName != '' ?
                  TextFieldAuto(
                      hintText: 'Адрес',
                      textInputType: TextInputType.text,
                      controller: adressController,
                      hintcolor: !_validate ? Colors.black26 : bordo(),
                      helperText: !_validate ? '' : 'Поле не может быть пустым',
                      userData: SharedData.adressList,
                      userDataText: AutofillHints.fullStreetAddress)
                   : TextFieldProfile(
                      hintText: 'Адрес',
                      textInputType: TextInputType.text,
                      controller: adressController,
                      hintcolor: !_validate ? Colors.black26 : bordo(),
                      helperText: !_validate ? '' : 'Поле не может быть пустым'),
                  TextFieldMultiline(
                      hintText: 'Комментарий к заказу',
                      controller: commentController,),
                  const SizedBox(height: 24,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Способ оплаты', style: textTheme.textTheme.labelLarge,)
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                                  (states) => const BorderSide(width: 1.0, color: Colors.black),
                            ),
                            fillColor: WidgetStateProperty.resolveWith(getColor),
                            value: isCheckedCard,
                            checkColor: bordo(),
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedCard = value!;
                                isCheckedCash = !value;
                                _payment = payment[1];
                              });
                            },
                          ),
                          Text('Онлайн перевод', style: textTheme.textTheme.titleMedium,)
                        ]
                      ),
                      Row(
                          children: [
                            Checkbox(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                    (states) => const BorderSide(width: 1.0, color: Colors.black),
                              ),
                              fillColor: WidgetStateProperty.resolveWith(getColor),
                              value: isCheckedCash,
                              checkColor: bordo(),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedCash = value!;
                                  isCheckedCard = !value;
                                  _payment = payment[0];
                                });
                              },
                            ),
                            Text('Наличными при получении', style: textTheme.textTheme.titleMedium,)
                          ]
                      ),
                      const SizedBox(height: 24,),
                      Column(
                        children: [
                          Text('Предварительная сумма к оплате', style: TextStyle(
                              fontFamily: 'OrelegaOne',
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: bordo())),
                          const SizedBox(width: 4,),
                          Text('${Cart.cartOrders.discount}', style: textTheme.textTheme.displayLarge,)
                        ],
                      ),
                      const SizedBox(width: 20,),
                      InkWell(
                          onTap: () async {
                            if(nameController.text.isEmpty) {
                              setState(() {
                                _validate = true;
                              });

                            } else if(phoneController.text.isEmpty) {
                              setState(() {
                                _validate = true;
                              });
                            } else if(adressController.text.isEmpty) {
                              setState(() {
                                _validate = true;
                              });
                            } else {
                              setState(() {
                                String orderList = '${Cart.orderModel.orderList}';
                                FirebaseFirestore.instance.collection('orders').doc(date).set(
                                  {
                                    'date' : date,
                                    'user_phone': phoneController.text,
                                    'user_name': nameController.text,
                                    'user_adress' : adressController.text,
                                    'order_list' : orderList,
                                    'total' : Cart.orderModel.total,
                                    'cash_card' : _payment,
                                    'comment' : commentController.text,
                                    'status' : 'не выполнен'
                                  }
                                );
                                if(SharedData.userName.isNotEmpty && SharedData.userPhone.isNotEmpty) {
                                  FirebaseFirestore.instance.collection('users')
                                      .doc(SharedData.userPhone)
                                      .collection('orders')
                                      .doc(date)
                                      .set(
                                          {
                                            'date' : date,
                                            'user_adress': adressController.text,
                                            'order_list': orderList,
                                            'total': Cart.orderModel.total,
                                          }
                                  );
                                }
                                streamController.add(15);
                                streamControllerBottom.add(1);
                                Cart.cartOrders.clearCart();
                              });
                              PushNotification.sendNotification(mtoken, context, 'У вас новый заказ!', 'Срочно загляните в приложение, не заставляйте клиента ждать!');
                              PushNotification.sendNotification(m2token, context, 'У вас новый заказ!', 'Срочно загляните в приложение, не заставляйте клиента ждать!');
                            }
                          },
                          child: const buttonFirebase(widthBtn: 300, heightBtn: 48, btnText: 'Отправить заказ', fontFamily: 'Roboto', fontSize: 16)),
                    ],
                  ),

                ],
              ),
            ],
          ),
      ),
    );
  }
}
