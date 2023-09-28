import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TodoUser? _userFromFirebaseUser(User? firebaseUser) {
    return firebaseUser != null ? TodoUser(uid: firebaseUser.uid) : null;
  }

  Future<TodoUser?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User fireBaseUser = userCredential.user!;
      return _userFromFirebaseUser(fireBaseUser);
    } catch (e) {
      return null;
    }
  }

  Future logIn(String email, String password) async {
     try {
      UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User fireBaseUser = userCredential.user!;
      return _userFromFirebaseUser(fireBaseUser);
    } catch (e) {
      return null;
    }
  }

  Stream<TodoUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
