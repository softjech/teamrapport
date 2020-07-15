import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefFunction {
  //code to store number locally
  Future<Null> saveNumberPreference(String number) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('myNumber', number);
  }

  //save bool value of isLogin locally
  Future<Null> saveLoginPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('isLogin', 'true');
  }

  //save bool value of isLogin locally for logout
  Future<Null> saveLogoutPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('isLogin', 'false');
  }

  //get isLogin value
  Future<String> getLoginPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('isLogin') != null) {
      return pref.getString('isLogin');
    }
    return null;
  }

  //get number
  Future<String> getNumberPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('myNumber') != null) {
      return pref.getString('myNumber');
    }
    return ' ';
  }

  //save user data -> for both teacher as well as student
  Future<Null> saveUserData(String number,List<String> studentData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(number, studentData);
    print('saved user data');
  }

  //Work for both teacher and student to get data
  Future<List<String>> getUserData(String number) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> temp = await pref.getStringList(number);
    print(temp);
    if ( temp != null) {
      return temp;
    }
    return null;
  }


}
