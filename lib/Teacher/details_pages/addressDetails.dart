import 'package:flutter/material.dart';

import '../../constants.dart';

class AddressDetails extends StatefulWidget {
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      height: size.height,
      width: size.width,
      color: Colors.blue,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            'Address Details',
            style: heading1.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
