import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:teamrapport/imageHandler/imageHandler.dart';
import 'package:teamrapport/loading/progress.dart';
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/teacher/details_pages/personalDetails.dart';
import 'package:teamrapport/teacher/teacherHome.dart';
import 'package:teamrapport/teacher/teacherVerification.dart';

import '../../checkUser.dart';
import '../../constants.dart';



class AddressDetails extends StatefulWidget {

  static const String routeName = '/login/checkUser/personalDetails/professionalDetails/addressDetails';
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {

  //bool _isHomeTutor = true; //This data is taken from ProfessionalDetails()
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String _addressDetails;
  TextEditingController landmarkController = TextEditingController();
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
        _addressDetails = value;
      },
    );
  }
  Widget _buildLandmark() {
    return myFromField(
      label: 'Landmark',
      controller: landmarkController,
      hint: 'New Delhi Railway Station.',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Landmark is required.';
        }
        return null;
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
  void initState() {
    getUserLocation();
    mobileNoController.text = myNumber;
    super.initState();
  }

  Future<void> getUserLocation() async {
    try {
      GeolocationStatus geolocationStatus =
      await Geolocator().checkGeolocationPermissionStatus();
      print(geolocationStatus);
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placeMarks = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark = placeMarks[0];
      landmarkController.text = placeMark.subLocality;
      countryController.text = placeMark.country;
      cityController.text = placeMark.subAdministrativeArea;
      stateController.text = placeMark.administrativeArea;
      pincodeController.text = placeMark.postalCode;
    } catch (e) {
      print(e);
    }
  }

  createFirebase(TeacherAllDetails data,String route) async {
    String profileUrl = '';
    setState(() {
      isLoading = true;
    });
    if (data.profileImgFile != null) {
      profileUrl = await ImageHandler().handleImage(data.profileImgFile,'profilePic');
    }
    DocumentReference docRef = usersRef.document(myNumber);
    await docRef.setData({
      'isTeacher': 'true',
      'homeTutor':data.homeTutor.toString(),
      'firstName': data.firstName,
      'lastName': data.lastName,
      'Name': data.firstName + ' ' + data.lastName,
      'popularName':data.popularName,
      'profilePic': profileUrl,
      'mobileNumber': myNumber,
      'email': data.emailId,
      'dob':data.dateOfBirth.toString(),
      'sex':data.sex,
      'education':data.educationalDetails,
      'experience':data.experience,
      'minFees':data.minFees,
      'maxFees':data.maxFees,
      'description':data.description,
      'address':_addressDetails,
      'landmark':landmarkController.text,
      'country': countryController.text,
      'state': stateController.text,
      'city': cityController.text,
      'pincode': pincodeController.text,
      'subject':data.subjects,
    });
    //SharedPrefFunction().saveUserData(myNumber, myData);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return isLoading ? circularProgress():Scaffold(
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
                  getUserLocation();
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
              Consumer<TeacherAllDetails>(
                builder:(_,value,__)=> myRaisedButton(
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
                    Provider.of<TeacherAllDetails>(context,listen: false).changeAddressDetail(mobileNoController.text,_addressDetails, landmarkController.text, countryController.text, stateController.text,countryController.text, pincodeController.text);
                    if(value.homeTutor){
                      createFirebase(value, TeacherVerification.routeName);
                    }else{
                      createFirebase(value,TeacherHomeScreen.routeName);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
