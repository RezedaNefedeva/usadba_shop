import 'package:flutter/material.dart';


Color bordo(){
  return const Color(0xff730909);
}


final theme = ThemeData(
  textTheme:  TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'OrelegaOne',
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: bordo()),
    bodyMedium: const TextStyle(
        fontFamily: 'OrelegaOne',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    labelLarge: TextStyle(
        fontFamily: 'OrelegaOne',
        fontSize: 24,
        fontWeight: FontWeight.w300,
        color: bordo()),
    displayMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: bordo()),
    displaySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: bordo()),
    titleLarge: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    titleMedium: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: bordo()),
    labelSmall: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: Colors.black),
    bodyLarge: const TextStyle(
      fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: Colors.black,
        ),
    bodySmall: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
    labelMedium: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w900,
      color: Colors.white,
  ),
  ),
);

