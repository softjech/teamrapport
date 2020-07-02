import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(30),
  ),
  borderSide: BorderSide(
      style: BorderStyle.solid,
      color: CupertinoDynamicColor.withBrightness(
          color: Color(0xFF1976D2), darkColor: Color(0xFF0D47A1))),
);

const kTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'DM Mono',
  fontWeight: FontWeight.bold,
  fontSize: 25,
  decoration: TextDecoration.none,
);
const kLabelStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'DM Mono',
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
);
