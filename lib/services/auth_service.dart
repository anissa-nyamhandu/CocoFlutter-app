import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// --- SIGN UP ---
  Future<User?> signUp({
    required String email,
    required String password,
    required String fullName,
    required List<String> niches,
    required String goal,
  }) async {
    try {
      // 1️⃣ Create user in Firebase Auth
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = cred.user!;

      // 2️⃣ Save extra data in Firestore
      await _db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'fullName': fullName,
        'niches': niches,
        'goal': goal,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
  
/// UPDATE NICHES & GOAL
Future<void> updateProfile({
  required String uid,
  required List<String> niches,
  required String goal,
}) async {
  try {
    await _db.collection('users').doc(uid).update({
      'niches': niches,
      'goal': goal,
      'updatedAt': FieldValue.serverTimestamp(), // optional, tracks when profile was updated
    });
  } catch (e) {
    // Provide a more descriptive error
    throw Exception('Failed to update profile: $e');
  }
}


  /// --- LOGIN ---
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// --- LOGOUT ---
  Future<void> logout() async {
    await _auth.signOut();
  }
}
