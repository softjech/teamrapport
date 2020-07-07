import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefFunction {
  //code to store number locally
  Future<Null> saveNumberPreference(String number) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('myNumber', number);
  }

  Future<Null> saveLoginPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('isLogin', 'true');
  }

  Future<Null> saveLogoutPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('isLogin', 'false');
  }

  //code to retrieve number
  Future<String> getLoginPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('isLogin') != null) {
      return pref.getString('isLogin');
    }
    return null;
  }

  Future<String> getNumberPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('myNumber') != null) {
      return pref.getString('myNumber');
    }
    return ' ';
  }
}
