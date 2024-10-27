
import 'dart:core';

import 'package:flutter/material.dart';

Column bottomItemActive (BuildContext context, String img, String text){

    final textTheme = Theme.of(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(padding: EdgeInsets.only(top: 16)),
          Image(
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              image: AssetImage(img)),
          const Padding(padding: EdgeInsets.only(top: 0)),
          Text(
            text,
            style: textTheme.textTheme.titleSmall,
          ),
        ]
    );
  }

