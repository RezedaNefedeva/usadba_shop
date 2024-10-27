
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/appBar/app_bar.dart';
import 'package:firebase_app/features/checkoutt_page/widgets/pickup.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/profile/widgets/btn_firebase.dart';
import 'package:firebase_app/features/profile/widgets/text_field.dart';
import 'package:firebase_app/local_services.dart';
import 'package:firebase_app/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_app/theme/theme.dart';
import '../../cart/cart.dart';
import '../../first_page/first_page.dart';
import '../../home/widgets/widgets.dart';
import '../../profile/widgets/shared_data.dart';
import '../widgets/text_form_fieald_auto.dart';

class checkoutPagePickUp extends StatefulWidget {
  const checkoutPagePickUp({super.key});

  @override
  State<checkoutPagePickUp> createState() => _checkoutPagePickUpState();
}

class _checkoutPagePickUpState extends State<checkoutPagePickUp> {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  String mtoken = '';
  String m2token = '';



  @override
  void initState() {
    super.initState();
    final messaging = FirebaseMessaging.instance;
    LocalNotificationServices.initialize(flutterLocalNotificationsPlugin);
    requestPermission();
    if(SharedData.userName != '')  getToken();
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

  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          saveToken(token!);
        }
    );
  }

  void saveToken(String token) async{
    await FirebaseFirestore.instance.collection('userTokens').doc(phoneController.text).set({
      'token' : token,
    });

  }

  void  adminToken() async {
    var adminToken = await FirebaseFirestore.instance.collection('userTokens').doc('89279589087').get();
    mtoken = adminToken['token'];

    var admin2Token = await FirebaseFirestore.instance.collection('userTokens').doc('89649624648').get();
    m2token = admin2Token['token'];
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool _validate = false;

  bool isCheckedCard = false;
  bool isCheckedCash = false;

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      // MaterialState.pressed,
      // MaterialState.hovered,
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
                const Pickup(),
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
                TextFieldMultiline(
                  hintText: 'Комментарий к заказу',
                  controller: commentController,),
                const SizedBox(height: 24,),
                Column(
                  children: [
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
                          }  else {
                            setState(() {
                              String orderList = '${Cart.orderModel.orderList}';
                              FirebaseFirestore.instance.collection('orders').doc(date).set(
                                  {
                                    'date' : date,
                                    'user_phone': phoneController.text,
                                    'user_name': nameController.text,
                                    'user_adress' : 'САМОВЫВОЗ',
                                    'order_list' : orderList,
                                    'total' : Cart.orderModel.total,
                                    'cash_card' : '',
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
                                      'user_adress': 'САМОВЫВОЗ',
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
                        child: const buttonFirebase(widthBtn: 300, heightBtn: 48, btnText: 'Отправить заказ', fontFamily: 'Roboto', fontSize: 16)
                    ),
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
