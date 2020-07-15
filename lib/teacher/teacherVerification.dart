import 'package:flutter/material.dart';

import '../constants.dart';

class TeacherVerification extends StatefulWidget {
  static const String routeName =
      '/login/checkUser/personalDetails/professionalDetails/addressDetails/teacherVerification';

  int _aadharNumber;

  @override
  _TeacherVerificationState createState() => _TeacherVerificationState();

/*
  This screen is only shown in case of Home tutor
   */
}

class _TeacherVerificationState extends State<TeacherVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _frontImage = false;
  bool _backImage = false;

  Widget _buildAadhar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        maxLengthEnforced: true,
        maxLength: 10,
        decoration: myInputDecoration(label: 'Aadhar Number'),
        validator: (String value) {
          if (value.isEmpty) return 'Aadhar number required';
          if (value.length < 10) return 'Invalid Aadhar number';
          return null;
        },
        onSaved: (String value) {
          widget._aadharNumber = int.tryParse(value);
        },
      ),
    );
  }

  Widget _buildAadharImage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add image of your Aadhar Card\'s front',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              //Implement accepting image
            },
            child: Container(
              padding: const EdgeInsets.all(8.9),
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: _frontImage
                  ? Image.network(
                      'blablabla',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/aadhar_placeholder_front.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add image of your Aadhar Card\'s back',
              style: subhead2.copyWith(fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              //Implement accepting image
            },
            child: Container(
              padding: const EdgeInsets.all(8.9),
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: _frontImage
                  ? Image.network(
                      'blablabla',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/aadhar_placeholder_back.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Verification',
          style: heading1.copyWith(fontSize: 24),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'As per our policy you need to verify yourself by providing your Aadhar card details. Read here',
                  style: subhead2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildAadhar(),
              _buildAadharImage(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Rapport will never share your Aadhar card details to any of its users or third party platforms.',
                  style: subhead2.copyWith(color: Colors.redAccent),
                ),
              ),

              //-------End of form-------
              SizedBox(
                height: 30,
              ),
              myRaisedButton(
                label: 'Next',
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
//                  print(widget._firstName + " " + widget._lastName);
//                  print(widget._popularName);
//                  print(widget._emailId);
//                  print(widget._sex);
//                  print(widget._aadharNumber);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
