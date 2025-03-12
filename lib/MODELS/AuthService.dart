import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Start the Google sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        print("Google sign-in was canceled");
        return null;
      }

      // 2. Retrieve authentication details from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Create Firebase credentials using the authentication details
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with the credentials
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user; // Return the authenticated user
    } catch (e) {
      // Catch any errors that occur during the process
      print("Error signing in with Google: $e");
      return null;
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    await _auth.signOut(); // Sign out from Firebase
    await _googleSignIn.signOut(); // Sign out from Google
    print("User signed out");
  }
}
