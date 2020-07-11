import 'package:flutter/material.dart';

import '../../constants.dart';

class ProfessionalDetails extends StatefulWidget {
  String _educationDetails;
  int _experience;
  int _feesMin, _feesMax;
  String _description;

  @override
  _ProfessionalDetailsState createState() => _ProfessionalDetailsState();
}

class _ProfessionalDetailsState extends State<ProfessionalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        widget._experience = int.tryParse(value);
      },
    );
  }

  Widget _buildFees() {
    return Row(
      children: <Widget>[
        Expanded(
          child: myFromField(
            keyBoardType: TextInputType.number,
            label: 'Lower value',
            validator: (String value) {
              widget._experience = int.tryParse(value);
            },
          ),
        ),
        Expanded(
          child: myFromField(
            keyBoardType: TextInputType.number,
            label: 'Upper Value',
            validator: (String value) {
              widget._experience = int.tryParse(value);
            },
          ),
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
        onSaved: (String value) {
          widget._description = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              _buildExperience(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text(
                  'Fees estimate',
                  style: subhead1.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              _buildFees(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Text(
                  'Enter the fee range for all the courses you provide included.',
                  style: subhead1,
                ),
              ),
              _buildDescription(),
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
