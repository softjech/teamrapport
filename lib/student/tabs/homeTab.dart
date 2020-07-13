import 'package:flutter/material.dart';

import '../../constants.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _studentName = 'Nishant';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Hello, ' + _studentName,
            style:
            heading1.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
