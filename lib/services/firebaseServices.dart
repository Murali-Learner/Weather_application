import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<FirebaseAuth> signUp({String email, String password}) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(_auth.currentUser.uid.toString());
    return _auth;
  }

  //SIGN IN METHOD
  Future<FirebaseAuth> signIn({String email, String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    return _auth;
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
