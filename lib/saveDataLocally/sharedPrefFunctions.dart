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

  //saveStudentData
  Future<Null> saveStudentData(String number,List<String> studentData) async {
    print(number);
    print(studentData);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(number, studentData);
    print('saved student data');
  }

  //saveTeacherData
  Future<Null> saveTeacherData(String number,List<String> studentData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList(number, studentData);
  }

  //getStudentData
  Future<List<String>> getStudentData(String number) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> temp = await pref.getStringList(number);
    print(temp);
    if ( temp != null) {
      return temp;
    }
    return null;
  }

  //getTeacherData
  Future<List<String>> getTeacherData(String number) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> temp = await pref.getStringList(number);
    if (temp != null) {
      return temp;
    }
    return null;
  }

}
