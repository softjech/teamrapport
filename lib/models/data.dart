class SliderModel {
  String _imagePath;
  String _title;
  String _desc;

  String get imagePath => _imagePath;

  set imagePath(String value) {
    _imagePath = value;
  } //SliderModel({this._desc, this._title, this._imagePath});


  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  List<SliderModel> getSlides() {
    List<SliderModel> slides = List<SliderModel>();
    SliderModel sliderModel = SliderModel();

    //1
    sliderModel.imagePath = 'assets/images/vectors/1.png';
    sliderModel.title = 'Quality';
    sliderModel.desc =
    'Discover the teachers around you to find the one that suits you the most.';
    slides.add(sliderModel);

    sliderModel = SliderModel();

    //2
    sliderModel.imagePath = 'assets/images/vectors/2.png';
    sliderModel.title = 'Opinion';
    sliderModel.desc =
    'Every opinion matters. Share what you feel without any pressure.';
    slides.add(sliderModel);

    sliderModel = SliderModel();

    //3
    sliderModel.imagePath = 'assets/images/vectors/3.png';
    sliderModel.title = 'Secure';
    sliderModel.desc = 'Your data our responsibility.';
    slides.add(sliderModel);

    sliderModel = SliderModel();

    //4
    sliderModel.imagePath = 'assets/images/vectors/4.png';
    sliderModel.title = 'Easy';
    sliderModel.desc = 'Intuitive  GUI design makes experience awesome.';
    slides.add(sliderModel);


    sliderModel = SliderModel();

    //5
    sliderModel.imagePath = 'assets/images/vectors/5.png';
    sliderModel.title = 'Audience';
    sliderModel.desc = 'If you are a teacher. You can reach out to a much great audience.';
    slides.add(sliderModel);
    return slides;
  }
}