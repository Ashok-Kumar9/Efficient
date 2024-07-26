import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficient_school/models/user.model.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionPath = 'users';

  Future<List<User>> getUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection(_collectionPath).get();
      return querySnapshot.docs
          .map((doc) => User.fromDocument(doc, doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _firebaseFirestore
          .collection(_collectionPath)
          .doc(userId)
          .get();
      if (doc.exists) {
        return User.fromDocument(doc, doc.id);
      }
      return null; // User not found
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser(User user) async {
    try {
      await _firebaseFirestore.collection(_collectionPath).add(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firebaseFirestore.collection(_collectionPath).doc(userId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
