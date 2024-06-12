import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  // Helper fucntion to get the full name
  String get fullName => '$firstName $lastName';

  // Format phone number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  //static function to split full name to first name and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //static funtion to generate a username from full name
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "rh_$camelCaseUsername";
    return usernameWithPrefix;
  }

  //static function to create an enpty userModel
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  /// Convert Model to JSon structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'userName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture
    };
  }

  // factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          userName: data['userName'] ?? '',
          email: data['Email'],
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    } else {
      return UserModel.empty();
    }
  }
}
