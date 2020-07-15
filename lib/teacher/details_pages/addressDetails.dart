import 'package:flutter/material.dart';
import 'package:teamrapport/teacher/teacherHome.dart';
import 'package:teamrapport/teacher/teacherVerification.dart';

import '../../constants.dart';

class AddressDetails extends StatefulWidget {

  static const String routeName = '/login/checkUser/personalDetails/professionalDetails/addressDetails';

  String _addressDetails;
  String _landmark;

  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {

  bool _isHomeTutor = true; //This data is taken from ProfessionalDetails()
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();


  Widget _buildAddressDetails() {
    return myFromField(
      label: 'Address',
      hint: 'House No. 123, ABC Colony',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address details are required.';
        }
        return null;
      },
      onSaved: (String value) {
        widget._addressDetails = value;
      },
    );
  }
  Widget _buildLandmark() {
    return myFromField(
      label: 'Landmark',
      hint: 'New Delhi Railway Station.',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Landmark is required.';
        }
        return null;
      },
      onSaved: (String value) {
        widget._addressDetails = value;
      },
    );
  }

  Widget _buildMobileNumber() {
    return myFromField(
      label: 'Mobile Number',
      controller: mobileNoController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mobile number is required.';
        }
        if (value.length != 13) {
          return 'Invalid mobile number';
        }
        return null;
      },
    );
  }

  Widget _buildCountry() {
    return myFromField(
      label: 'Country',
      controller: countryController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Country is required.';
        }

        return null;
      },
    );
  }

  Widget _buildState() {
    return myFromField(
      label: 'State',
      controller: stateController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'State is required.';
        }

        return null;
      },
    );
  }

  Widget _buildCity() {
    return myFromField(
      label: 'City',
      controller: cityController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is required.';
        }

        return null;
      },
    );
  }

  Widget _buildPincode() {
    return myFromField(
      label: 'PIN Code',
      controller: pincodeController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'PIN code is required.';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Contact Details',
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
              _buildMobileNumber(),
              _buildAddressDetails(),
              _buildLandmark(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: _buildCity(),
                  ),
                  Expanded(child: _buildState()),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: _buildCountry(),
                  ),
                  Expanded(
                    child: _buildPincode(),
                  ),
                ],
              ),
              FlatButton.icon(
                onPressed: () {
                  //getUserLocation();
                },
                icon: Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
                label: Text(
                  'Use current Location',
                  style: subhead2,
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
                  if(_isHomeTutor){
                    Navigator.of(context).pushReplacementNamed(TeacherVerification.routeName);
                  }else{
                    Navigator.of(context).pushReplacementNamed(TeacherHomeScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
