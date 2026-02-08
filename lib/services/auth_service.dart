import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// SIGN UP
  Future<User?> signUp({
    required String email,
    required String password,
    required String fullName,
    required List<String> niches,
    required String goal,
  }) async {
    // 1. Create user in Firebase Auth
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = cred.user!;

    // 2. Save extra data in Firestore
    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': email,
      'fullName': fullName,
      'niches': niches,
      'goal': goal,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  /// LOGIN
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    UserCredential cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return cred.user;
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}
