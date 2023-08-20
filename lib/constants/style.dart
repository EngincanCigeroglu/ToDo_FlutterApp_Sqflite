import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style{
  static const headStyle = TextStyle(
      fontSize: 20 , fontWeight: FontWeight.bold, color: Colors.white
  );

  static const pageDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF004e92), Color(0xFF000428)],
      begin: Alignment.bottomCenter,
      end:Alignment.topCenter,
    ),
  );

  static const fieldDecoration = BoxDecoration(
    color: Colors.white24,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  static const cardDecorationLow = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    gradient: LinearGradient(
      colors: [Color(0xffa4ce72), Color(0xFF56ab2f)],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ),
  );

  static const cardDecorationMedium = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    gradient: LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [Color(0xFFFDC830),Color(0xFFF37335)],
    ),
  );

  static const cardDecorationHigh = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    gradient: LinearGradient(
      colors: [Color(0xFFFF4B2B), Color(0xFFFF416C)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );


}









