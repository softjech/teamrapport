import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

//Text styles

//small heading
TextStyle heading1 = GoogleFonts.montserrat(
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

//small heading with Roboto
TextStyle heading2 = GoogleFonts.roboto(
  fontSize: 20,
  fontWeight: FontWeight.w700,
);

//description
TextStyle subhead1 = GoogleFonts.montserrat(
  fontSize: 10,
  color: Colors.black54,
);

//subheading
TextStyle subhead2 = GoogleFonts.montserrat(
  fontSize: 12,
  color: Colors.black54,
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
const kTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(30),
  ),
  borderSide: BorderSide(
      style: BorderStyle.solid,
      color: CupertinoDynamicColor.withBrightness(
          color: Color(0xFF1976D2), darkColor: Color(0xFF0D47A1))),
);

//Custom Input decoration
InputDecoration myInputDecoration({ label, hint}){
  return InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(15),
    labelText: label,
    labelStyle: subhead2,
    hintText: hint,
    focusedBorder: completeInputBorder,
    border: completeInputBorder,
  );
}

//Custom Input Field
Widget myTextField({onChanged, label, keyboardType}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
    child: TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: myInputDecoration(label: label),
    ),
  );
}

//Customized Form Field
Widget myFromField({label, hint, validator, onSaved}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 8),
    child: TextFormField(
      decoration: myInputDecoration(label : label, hint: hint),
      validator: validator,
      onSaved: onSaved,
    ),
  );
}

//Customized raisedButton
Widget myRaisedButton({onPressed, label}){
 return Container(
   margin: EdgeInsets.all(10),
    width: double.infinity,
    height: 50,
    child: RaisedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
//                            fontWeight: FontWeight.bold,
        ),
      ),
//                          color: Color.fromRGBO(119, 205, 208, 1),
      color: themeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
//                          side: BorderSide(color: Colors.black),
      ),
    ),
  );
}

