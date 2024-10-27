
import 'package:firebase_app/features/first_page/view/firstPage.dart';
import 'package:firebase_app/features/first_page/widgets/bottomNav.dart';
import 'package:firebase_app/features/home/widgets/button-design.dart';
import 'package:firebase_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:telegram_link/telegram_link.dart';
import 'package:url_launcher/url_launcher.dart';

class contact extends StatefulWidget {
  const contact({super.key});

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          Column(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkResponse(
                      enableFeedback: false,
                      onTap: () {
                        streamController.add(5);
                        streamControllerBottom.add(0);
                      },
                      child: const Image(
                        image: AssetImage('assets/icons/adress.png'),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Text('г. Сибай уд.Крупской д.3а', style: textTheme.textTheme.displayMedium,)
                  ]
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkResponse(
                  enableFeedback: false,
                  onTap: () {
                  },
                  child: const Image(
                    image: AssetImage('assets/icons/clock.png'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                Text('График работы:\nВторник-Пятница с 10.00 до 19.00\nСуббота-Воскресенье с10.00 до 18.00\nПонедельник выходной',
                  style: textTheme.textTheme.displaySmall,)
              ]
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          const buttonDesign(widthBtn: 280, heightBtn: 40, btnText: 'Посмотреть на карте', fontFamily: 'Roboto', indexNav: 5, fontSize: 14),
          const Padding(padding: EdgeInsets.only(top: 20)),
          TextButton(
                onPressed: (){
                    launch('tel:+79649624648');
          },
                child: Text('+7(964)962-46-48', style: theme.textTheme.displayLarge,),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkResponse(
                  enableFeedback: false,
                  onTap: () {
                    launch('tel:+79649624648');
                  },
                  child: const Image(
                    image: AssetImage('assets/icons/phone_btn.png'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 40)),
                InkResponse(
                  enableFeedback: false,
                  onTap: () {
                    launch(TelegramLink(phoneNumber: '+79649624648').toString());
                  },
                  child: const Image(
                    image: AssetImage('assets/icons/telegramm_btn.png'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 40)),
                InkResponse(
                  enableFeedback: false,
                  onTap: () {
                    launch('whatsapp://send?phone=+79649624648');
                  },
                  child: const Image(
                    image: AssetImage('assets/icons/whatsapp_btn.png'),
                  ),
                ),
              ]
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
        ],
      ),
    );
  }
}
