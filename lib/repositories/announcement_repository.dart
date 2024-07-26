import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/announcement.model.dart';

class AnnouncementRepository {
  final FirebaseFirestore firestore;

  AnnouncementRepository({required this.firestore});

  // fetch all announcements in descending order
  Future<List<Announcement>> getAnnouncements() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('announcements')
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => Announcement.fromDocument(doc, doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // add announcement
  Future<void> addAnnouncement(Announcement announcement) async {
    try {
      await firestore.collection('announcements').add(announcement.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // delete announcement
  Future<void> deleteAnnouncement(String docId) async {
    try {
      await firestore.collection('announcements').doc(docId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
