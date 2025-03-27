import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smatpay/utils/formatters/formatters.dart';

/// Model class representing user data
class TUserModel {
  // Keep those values final which you do not want to update

  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  /// Constructor for TUserModel

  TUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name
  String get fullName => '$firstName  $lastName';

  /// Helper function to format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Helper function to split full name into first and last
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Helper function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toString();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername =
        '$firstName $lastName'; // Combine first and last name
    String usernameWithPrefix =
        'smatpayer_$camelCaseUsername'; // Add 'cat_' prefix
    return usernameWithPrefix;
  }

  /// Static function to vreate on empty user model
  static TUserModel empty() => TUserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  /// Convert model to JSON structure for staring data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method to create a TUserModel from a Firebase document snapshot .
  factory TUserModel.fromSnashot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      final data = document.data()!;
      return TUserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      // Handle the case when document data is null
      return TUserModel.empty();
    }
  }
}
