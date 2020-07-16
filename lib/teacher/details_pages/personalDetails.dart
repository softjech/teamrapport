import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:teamrapport/constants.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as Im;
import 'package:teamrapport/login/loginScreen.dart';
import 'package:teamrapport/models/subjectData.dart';
import 'package:teamrapport/teacher/details_pages/professionalDetails.dart';

class PersonalDetails extends StatefulWidget {

  static const String routeName = '/login/checkUser/personalDetails';


  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File file;
  String _dateError;
  String _firstName;
  String _lastName;
  String _popularName;
  String _emailId;
  DateTime _dateOfBirth;
  int _sex = 0; // 0 - male 1 - female 2 - other
  List<String> x = [];

//  var _genderMap = {
//    0 : 'Male',
//    1 : 'Female',
//    2 : 'Other',
//  };
//  bool _profileSet = false;

  handleTakePhoto() async {
    Navigator.pop(context);
    // ignore: deprecated_member_use
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      this.file = file;
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    File file =
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          elevation: 50,
          backgroundColor: Colors.white,
          //contentPadding: EdgeInsets.all(20.0),
          titlePadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              'Upload Profile Picture',
              style: heading2,
            ),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'From Camera',
                    style: subhead2,
                  ),
                ],
              ),
              onPressed: handleTakePhoto,
            ),
            SimpleDialogOption(
              onPressed: handleChooseFromGallery,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.image,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'From Gallery',
                    style: subhead2,
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  'Cancel',
                  style: subhead2.copyWith(
                    fontSize: 14,
                    color: themeColor,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        );
      },
    );
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$myNumber.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  Widget _getProfilePic() {
    return Material(
      elevation: 10,
      shape: CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: GestureDetector(
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width *0.15,
            backgroundImage: file != null
                ? FileImage(file)
                : AssetImage(
                    'assets/images/default.png',
                  ),
            backgroundColor: Colors.transparent,
          ),
          onTap: () {
              selectImage(context);
              setState(() {
                file =null;
              });
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
        _firstName = value;
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
        _lastName = value;
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
            _popularName = value;
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
        _emailId = value;
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
                  value: '$_sex',
                  //This line here could break, if that happens. The value in the sex field will be wrong
                  /*
                  Sol: uncomment the _genderMap above and in the value add the following code
                  _genderMap[widget._sex]
                   */
                  hint: Text('Select gender'),
                  onChanged: (value) {
                    setState(() {
                      _sex = int.tryParse(value);
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
                      initialDate: _dateOfBirth == null
                          ? DateTime.now()
                          : _dateOfBirth,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      setState(() {
                        _dateOfBirth = value;
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
                        _dateOfBirth != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(_dateOfBirth)
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

              myRaisedButton(
                label: 'Next',
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  if (_dateOfBirth == null) {
                    setState(() {
                      _dateError = 'Please set date first.';
                    });
                  }
                  _formKey.currentState.save();
                  print(_firstName + " " + _lastName);
                  print(_popularName);
                  print(_emailId);
                  print(_sex);
                  print(_dateOfBirth);
                  Provider.of<TeacherAllDetails>(context,listen: false).changePersonalDetail(file, _firstName, _lastName, _popularName, _emailId, _dateOfBirth, _sex);
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

class TeacherAllDetails extends ChangeNotifier{
  File profileImgFile;
  String firstName;
  String lastName;
  String popularName;
  String emailId;
  DateTime dateOfBirth;
  int sex = 0;// 0 - male 1 - female 2 - other
  String educationalDetails;
  int experience;
  List<SubjectObject> subjects=[];
  int minFees,maxFees;
  String description;
  bool homeTutor;
  String mobileNo;
  String address,landmark,city,state,country,pincode;




  void changePersonalDetail (File profilePic,String fName,String lName,String pName,String email,DateTime dob,int s){
    profileImgFile = profilePic;
    firstName = fName;
    lastName = lName;
    popularName = pName;
    emailId = email;
    dateOfBirth = dob;
    sex =s;
    notifyListeners();
  }
  void changeAddressDetail(String mNo,String add,String land,String c,String s,String con,String pin){
    mobileNo = mNo;
    address =add;
    landmark =land;
    city = c;
    country = con;
    state =s;
    pincode = pin;
    notifyListeners();
  }
  void changeProfessionalDetail(String eDetails,String des,int mFees,int maxF,int e,List<SubjectObject> sub,bool hTutor){
    educationalDetails =eDetails;
    homeTutor = hTutor;
    description =des;
    minFees = mFees;
    maxFees = maxF;
    experience =e;
    subjects = sub;
    notifyListeners();
  }
}