import 'package:flutter/material.dart';

import '../../constants.dart';

class ProfessionalDetails extends StatefulWidget {
  @override
  _ProfessionalDetailsState createState() => _ProfessionalDetailsState();
}

class _ProfessionalDetailsState extends State<ProfessionalDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      height: size.height,
      width: size.width,
      color: Colors.red,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(
            'Professional Details',
            style: heading1.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
