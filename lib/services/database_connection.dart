import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String> register({String email, String password}) async {

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return "successful";
  
  } on FirebaseAuthException catch (err) {
    if (err.code == "invalid-email") return "Invalid Email.";

    if (err.code == 'weak-password') return "Weak Password";

    if (err.code == 'email-already-in-use') return "Email is already in use.";
  }
  return "Cannot Perform Action.";
}

Future<String> signIn({String email, String password}) async {
  
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return "successful";
  } on FirebaseAuthException catch (err) {
    if (err.code == "invalid-email") return "Invalid Email.";

    if (err.code == "user-not-found") return "User is not found.";

    if (err.code == "wrong-password") return "Wrong Password.";
  }
  return "Cannot Perform Action.";
}

Future<void> signOut() async {

  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print("SIGN OUT ERROR: " + e.toString());
  }
}

Future<bool> loginWithGoogle() async {

  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount account = await googleSignIn.signIn();

    if (account == null)
      return false;

    final googleAuth = await account.authentication;
    
    UserCredential user = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    ));

    if (user.user == null)
      return false;

    return true;
    
  } catch (e) {
    print("LOGIN WITH GOOGLE ERROR: " + e.toString());
  }
}