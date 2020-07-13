import 'package:cloud_firestore/cloud_firestore.dart';

class StudentData {

  final String firstName;
  final String lastName;
  final String email;
  final String myNumber;
  final String state;
  final String city;
  final String pincode;
  final String country;
  final String name;
  final String mediaUrl;
  final String isTeacher;

  StudentData({
    this.firstName,
    this.lastName,
    this.email,
    this.myNumber,
    this.state,
    this.city,
    this.pincode,
    this.country,
    this.name,
    this.mediaUrl,
    this.isTeacher});

  factory StudentData.fromDocument(DocumentSnapshot doc){
    return StudentData(
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      name: doc['Name'],
      email: doc['email'],
      myNumber: doc['mobileNumber'],
      mediaUrl: doc['profilePic'],
      city: doc['city'],
      state: doc['state'],
      country: doc['country'],
      pincode: doc['pincode'],
      isTeacher: doc['isTeacher'].toString(),
    );
  }

  factory StudentData.fromList(List<String> doc){
    return StudentData(
      name: doc[1]+' '+doc[2],
      firstName: doc[1],
      lastName: doc[2],
      email: doc[3],
      myNumber: doc[4],
      state: doc[6],
      city: doc[7],
      country: doc[5],
      pincode: doc[8],
      mediaUrl: doc[9],
      isTeacher: doc[0],
    );
  }

}