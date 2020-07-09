import 'package:flutter/material.dart';
import 'package:teamrapport/teacher/details_pages/addressDetails.dart';
import 'package:teamrapport/teacher/details_pages/personalDetails.dart';
import 'package:teamrapport/teacher/details_pages/professionalDetails.dart';

class SliderModel {
  Widget _widget;

  Widget get widget => _widget;

  set widget(Widget value) {
    _widget = value;
  }

  List<SliderModel> getSlides() {
    List<SliderModel> slides = List<SliderModel>();

    SliderModel sliderModel = SliderModel();

    //1
    sliderModel.widget = PersonalDetails();

    slides.add(sliderModel);

    sliderModel = SliderModel();

    //2
    sliderModel.widget = ProfessionalDetails();

    slides.add(sliderModel);

    sliderModel = SliderModel();

    //3
    sliderModel.widget = AddressDetails();

    slides.add(sliderModel);

    return slides;
  }
}