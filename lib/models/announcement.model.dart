import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String? docId;
  final String title;
  final String description;
  final List<String> mediaFiles;
  final DateTime createdAt;
  final String userName;
  final String profileImage;
  final int likeCount;
  final int commentCount;

  Announcement({
    this.docId,
    required this.title,
    required this.description,
    required this.mediaFiles,
    required this.createdAt,
    required this.userName,
    required this.profileImage,
    required this.likeCount,
    required this.commentCount,
  });

  // Method to convert an Announcement instance to a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'mediaFiles': mediaFiles,
      'createdAt': createdAt.toIso8601String(),
      'userName': userName,
      'profileImage': profileImage,
      'likeCount': likeCount,
      'commentCount': commentCount,
    };
  }

  // Method to create an Announcement instance from a document snapshot
  factory Announcement.fromDocument(DocumentSnapshot doc, String docId) {
    final data = doc.data() as Map<String, dynamic>;
    return Announcement(
      docId: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      mediaFiles: List<String>.from(data['mediaFiles'] ?? []),
      createdAt: DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
      userName: data['userName'] ?? '',
      profileImage: data['profileImage'] ?? '',
      likeCount: data['likeCount'] ?? 0,
      commentCount: data['commentCount'] ?? 0,
    );
  }
}
