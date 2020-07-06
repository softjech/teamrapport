import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const themeColor = Color.fromRGBO(0, 136, 170, 1);

const leftTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    bottomLeft: Radius.circular(10),
  ),
);

const rightTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ),
);

const completeInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
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
