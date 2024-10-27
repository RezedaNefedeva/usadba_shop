
import 'package:flutter/material.dart';


class Header extends StatelessWidget {
  const Header({super.key, required this.title});
  final String title;



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top:120)),
        Text(title, style: theme.textTheme.displayLarge,),
      ],
    );
  }
}
