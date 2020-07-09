import 'package:flutter/material.dart';
import 'package:teamrapport/constants.dart';

class PersonalDetails extends StatefulWidget {
  String _firstName;
  String _lastName;
  String _popularName;
  String _emailId;
  String _about;
  DateTime _dateOfBirth;
  int _sex; // 0 - male 1 - female 2 - other

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildFirstName() {
    return myFromField(
      label: 'First Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'First name is required';
        }
      },
      onSaved: (String value) {
        widget._firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return myFromField(
      label: 'Last Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last name is required.';
        }
      },
      onSaved: (String value) {
        widget._lastName = value;
      },
    );
  }

  Widget _buildPopularName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        myFromField(
          label: 'Popular Name',
          onSaved: (String value) {
            widget._lastName = value;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10,),
          child: Text('This is a name that you are most commonly know by (if any).', style: subhead1,),
        )
      ],
    );
  }

  Widget _buildEmail() {
    return myFromField(
      label: 'Email Address',
      hint: 'someone@example.com',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required.';
        }
      },
      onSaved: (String value) {
        widget._lastName = value;
      },
    );
  }

  Widget _buildSex() {
    return null;
  }

  Widget _buildDob() {
    return null;
  }

  Widget _buildAbout() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Personal Details',
          style: heading1.copyWith(fontSize: 24),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildFirstName(),
                  ),
                  Expanded(
                    child: _buildLastName(),
                  ),
                ],
              ),
            _buildPopularName(),
//            _buildDob(),
//            _buildSex(),
            _buildEmail(),
//            _buildAbout(),
              myRaisedButton(
                label: 'Next',
                onPressed: () {
                  if(!_formKey.currentState.validate()){
                    return;
                  }
                  _formKey.currentState.save();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
