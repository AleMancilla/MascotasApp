import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';

// Trigger the authentication flow
GoogleSignInAccount? googleUser;

// Obtain the auth details from the request
GoogleSignInAuthentication? googleAuth;

// Create a new credential
// ignore: prefer_typing_uninitialized_variables
var credential;

Future<UserCredential> signInWithGoogle() async {
  GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> signOutWithGoogleAndFirebase() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().disconnect();
}
