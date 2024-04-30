// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   Future<bool> loginByGoogle() async {
//     GoogleSignIn googleSignIn = GoogleSignIn(
//       scopes: [
//         'email',
//       ],
//     );

//     try {
//       await googleSignIn.disconnect();
//     } catch (_) {}

//     try {
//       GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//       GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//       var userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       return true;
//     } catch (_) {
//       return false;
//     }
//   }
// }

//   // // Fungsi untuk logout
//   // Future<void> logout() async {
//   //   await firebaseAuth.signOut();
//   //   await googleSignIn.signOut();
//   //   await SharedPrefsHelper.removeToken(); // Hapus token dari SharedPrefs
//   //   print(
//   //       "google: Logged out from Google and Firebase, and cleared local storage.");
//   // }

//   // // ketika user nya null auto logout
//   // Future<void> autoLogoutIfNeeded() async {
//   //   var user = firebaseAuth.currentUser;
//   //   var token = await user?.getIdToken();

//   //   if (user == null || token == null) {
//   //     print("User or token is null, performing automatic logout.");
//   //     await logout(); // Memanggil fungsi logout yang sudah ada
//   //   }
//   // }
