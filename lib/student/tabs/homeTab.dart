import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamrapport/main.dart';

import '../../constants.dart';

class HomeTab extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    //String studentName =Provider.of<Data>(context,listen: false).myRealData[1];
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.02,
          ),
          Consumer<Data>(
            builder:(_,studentName,__)=> Text(
              'Hello, ' + studentName.myRealData[1].toString(),
              style:
              heading1.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
