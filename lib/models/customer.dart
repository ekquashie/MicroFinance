import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String firstName;
  String lastName;
  String gender;
  String profession;
  String nationality;
  double currentAmount;
  String phone;
  String location;
  String accountType;
  String date;
  String user;

  Customer(
      this.firstName,
      this.lastName,
      this.gender,
      this.profession,
      this.nationality,
      this.phone,
      this.location,
      this.currentAmount,
      this.accountType,
      this.user,
      this.date);

  Map<String, dynamic> customerJson() => {
        "firstname": firstName,
        "lastname": lastName,
        "gender": gender,
        'profession': profession,
        "nationality": nationality,
        "customer": firstName + " " + lastName,
        "phone": phone,
        "location": location,
        "current": currentAmount,
        "created by": user,
        "date": date,
        "account type": accountType,
      };

  Customer.fromSnapshot(DocumentSnapshot snapshot)
      : firstName = snapshot['firstname'],
        lastName = snapshot['lastname'];
  // gender = snapshot['gender'],
  // profession = snapshot['profession'],
  // nationality = snapshot['nationality'],
  // currentAmount = snapshot['current'],
  // phone = snapshot['phone'],
  // location = snapshot['location'],
  // date = snapshot['date'],
  // user = snapshot['user'],
  // accountType = snapshot['account type'];
}
