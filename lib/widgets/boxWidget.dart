import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/constants.dart';

// This is the widget used to make Teacher or Student choice.
class BoxWidget extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback onTap;
  final Color color;

  BoxWidget({this.title, this.desc, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5.0,
        child: Container(
          height: size.width / 2.5,
          width: size.width / 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                title,
                style: heading1,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  desc,
                  style: subhead1,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 10,
                width: double.infinity,

                decoration: BoxDecoration(
                  color: color.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
