import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefFunction {
  //code to store number locally
  Future<Null> saveNumberPreference(String number) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('myNumber', number);
    print('done');
  }

  //code to retrieve number
  Future<String> getNumberPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('myNumber') != null) {
      return pref.getString('myNumber');
    }
    print(pref.getString('myNumber'));
    return ' ';
  }
}
