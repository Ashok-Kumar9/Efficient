import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? userDocId;
  final String userName;
  final String profileImage;

  User({
    this.userDocId,
    required this.userName,
    required this.profileImage,
  });

  // Method to convert a User instance to a map
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'profileImage': profileImage,
    };
  }

  // Method to create a User instance from a document snapshot
  factory User.fromDocument(DocumentSnapshot doc, String userDocID) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      userDocId: userDocID,
      userName: data['userName'] ?? '',
      profileImage: data['profileImage'] ?? '',
    );
  }
}
