import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:teamrapport/models/subjectData.dart';
import 'package:teamrapport/teacher/details_pages/addressDetails.dart';
import '../../constants.dart';

class ProfessionalDetails extends StatefulWidget {
  static const String routeName =
      '/login/checkUser/personalDetails/professionalDetails';

  String _educationDetails;
  int _experience;
  int _feesMin, _feesMax;
  String _description;
  List<SubjectObject> _subjects;
  bool _homeTutor = false;

  @override
  _ProfessionalDetailsState createState() => _ProfessionalDetailsState();
}

class _ProfessionalDetailsState extends State<ProfessionalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//  final GlobalKey<ChipsInputState> _chipKey = GlobalKey();

  Widget _buildEducationDetails() {
    return myFromField(
      label: 'Education Details',
      hint: 'XYZ degree from ABC university.',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter education details.';
        }
        return null;
      },
      onSaved: (String value) {
        widget._educationDetails = value;
      },
    );
  }

  Widget _buildExperience() {
    return myFromField(
        keyBoardType: TextInputType.number,
        label: 'Experience(in years)',
        validator: (String value) {
          if (value.isEmpty) return 'Please enter experience.';
          return null;
        },
        onSaved: (String value) {
          widget._experience = int.tryParse(value);
        });
  }

  Widget _buildFees() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10.0),
          child: Text(
            'Fees Estimate',
            style: subhead2.copyWith(fontSize: 12),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: myFromField(
                  keyBoardType: TextInputType.number,
                  label: 'Lower value',
                  validator: (String value) {
                    if (value.isEmpty) return 'Please enter lower fees value.';
//                    if (int.tryParse(value) > widget._feesMax)
//                      return 'Should be lower';
                    return null;
                  },
                  onSaved: (String value) {
                    widget._feesMin = int.tryParse(value);
                  }),
            ),
            Expanded(
              child: myFromField(
                keyBoardType: TextInputType.number,
                label: 'Upper Value',
                validator: (String value) {
                  if (value.isEmpty) return 'Please enter upper fees value.';
//                  if (int.tryParse(value) < widget._feesMin)
//                    return 'Should be greater';
                  return null;
                },
                onSaved: (String value) {
                  widget._feesMax = int.tryParse(value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: TextFormField(
        minLines: 4,
        maxLines: 4,
        decoration: myInputDecoration(
          label: 'Brief description about the subjects that you teach.',
        ),
        validator: (String value) {
          if (value.isEmpty) return 'Please enter upper fees value.';
          return null;
        },
        onSaved: (String value) {
          widget._description = value;
        },
      ),
    );
  }

  void _onChipTapped(SubjectObject subject) {
    print('$subject');
  }

  void _onChanged(List<SubjectObject> data) {
    print('onChanged $data');
    widget._subjects = data;
  }

  Future<List<SubjectObject>> _findSuggestions(String query) async {
    if (query.length > 1) {
      return subjectData.where((subject) {
        return subject.name.toLowerCase().contains(query.toLowerCase());
      }).toList(growable: false);
    } else {
      return const <SubjectObject>[];
    }
  }

  Widget _buildSubjects() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ChipsInput<SubjectObject>(
        decoration: myInputDecoration(
          //prefixIcon: Icon(Icons.search),
          label: 'Subjects Taught',
        ),
        initialValue: [subjectData[0]],
        allowChipEditing: false,
        findSuggestions: _findSuggestions,
        onChanged: _onChanged,
        chipBuilder: (BuildContext context,
            ChipsInputState<SubjectObject> state, SubjectObject subject) {
          return InputChip(
            key: ObjectKey(subject),
            label: Text(subject.name),
            onDeleted: () => state.deleteChip(subject),
            onSelected: (_) => _onChipTapped(subject),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        },
        suggestionBuilder: (BuildContext context,
            ChipsInputState<SubjectObject> state, SubjectObject subject) {
          return ListTile(
            key: ObjectKey(subject),
            title: Text(subject.name),
            onTap: () => state.selectSuggestion(subject),
          );
        },
      ),
    );
  }

  Widget _buildHomeTutor() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text(
            'You are a home tutor.',
            style: subhead2.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Switch.adaptive(
              activeColor: themeColor,
              value: widget._homeTutor,
              onChanged: (value) {
                setState(() {
                  widget._homeTutor = value;
                });
              })
        ],
      ),
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
          'Professional Details',
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
              _buildEducationDetails(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Text(
                  'Specify about your education.',
                  style: subhead1,
                ),
              ),
              _buildExperience(),
              _buildFees(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Text(
                  'Enter the fee range for all the courses you provide included.',
                  style: subhead1,
                ),
              ),
              _buildSubjects(),
              _buildDescription(),
              _buildHomeTutor(),

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
                  Navigator.pushReplacementNamed(
                      context, AddressDetails.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
