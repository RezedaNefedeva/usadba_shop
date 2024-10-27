
import 'package:flutter/material.dart';

Column bottomItem(BuildContext context, String img, String text){

  final textTheme = Theme.of(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(padding: EdgeInsets.only(top: 26)),
          Image(
              width: 32,
              height: 32,
              fit: BoxFit.cover,
              image: AssetImage(
                  img)),
          const Padding(padding: EdgeInsets.only(top: 0)),
          Text(
            text,
            style: textTheme.textTheme.labelSmall,
          ),
        ]
    );
  }
