import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamrapport/constants.dart';
import 'package:intl/intl.dart';
import 'package:teamrapport/teacher/details_pages/professionalDetails.dart';

class PersonalDetails extends StatefulWidget {

  static const String routeName = '/login/checkUser/personalDetails';

  String _firstName;
  String _lastName;
  String _popularName;
  String _emailId;
  DateTime _dateOfBirth;
  int _sex = 0; // 0 - male 1 - female 2 - other


  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _dateError;

//  var _genderMap = {
//    0 : 'Male',
//    1 : 'Female',
//    2 : 'Other',
//  };
  bool _profileSet = false;

  Widget _getProfilePic() {
    return Material(
      elevation: 10,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: GestureDetector(
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width *0.15,
            backgroundImage: _profileSet
                ? NetworkImage('https://via.placeholder.com/150')
                : AssetImage(
                    'assets/images/default.png',
                  ),
            backgroundColor: Colors.transparent,
          ),
          onTap: () {
            //Implement setting up of profile Image here.
          },
        ),
      ),
    );
  }

  Widget _buildFirstName() {
    return myFromField(
      label: 'First Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'First name is required';
        }
        return null;
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
        return null;
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
            widget._popularName = value;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            bottom: 10,
          ),
          child: Text(
            'This is a name that you are most commonly know by (if any).',
            style: subhead1,
          ),
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
        if (!RegExp(
                r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
            .hasMatch(value)) {
          return 'invalid email address';
        }
        return null;
      },
      onSaved: (String value) {
        widget._emailId = value;
      },
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems = [
    DropdownMenuItem<String>(
      value: '0',
      child: Center(
        child: Text('Male'),
      ),
    ),
    DropdownMenuItem<String>(
      value: '1',
      child: Center(
        child: Text('Female'),
      ),
    ),
    DropdownMenuItem<String>(
      value: '2',
      child: Center(
        child: Text('Other'),
      ),
    ),
  ];

  Widget _buildSex() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                'Sex',
                style: subhead2.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38)),
              child: Center(
                child: DropdownButton<String>(
                  isExpanded: true,
                  items: _dropDownItems,
                  value: '${widget._sex}',
                  //This line here could break, if that happens. The value in the sex field will be wrong
                  /*
                  Sol: uncomment the _genderMap above and in the value add the following code
                  _genderMap[widget._sex]
                   */
                  hint: Text('Select gender'),
                  onChanged: (value) {
                    setState(() {
                      widget._sex = int.tryParse(value);
                    });
                  },
                  style: subhead2,
                  underline: Container(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDob() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(
                    'Date of Birth',
                    style: subhead2.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: widget._dateOfBirth == null
                          ? DateTime.now()
                          : widget._dateOfBirth,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      setState(() {
                        widget._dateOfBirth = value;
                      });
                    });
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38)),
                    child: Center(
                      child: Text(
                        widget._dateOfBirth != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(widget._dateOfBirth)
                            : 'Select date',
                        style: subhead2.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _dateError !=null ? Text(
            _dateError,
            style: subhead1.copyWith(
              color: Colors.redAccent,
            ),
          ):
          Container(),
        ],
      ),
    );
    ;
  }


  @override
  Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
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
              _getProfilePic(),
              SizedBox(
                height: 60,
              ),
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
              _buildSex(),
              _buildDob(),
              _buildEmail(),
              SizedBox(
                height: 30,
              ),

//            _buildAbout(),
//              _buildAadhar(),
              myRaisedButton(
                label: 'Next',
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  if (widget._dateOfBirth == null) {
                    setState(() {
                      _dateError = 'Please set date first.';
                    });
                  }
                  _formKey.currentState.save();
                  print(widget._firstName + " " + widget._lastName);
                  print(widget._popularName);
                  print(widget._emailId);
                  print(widget._sex);
                  print(widget._dateOfBirth);
                  Navigator.of(context).pushReplacementNamed(ProfessionalDetails.routeName);
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
