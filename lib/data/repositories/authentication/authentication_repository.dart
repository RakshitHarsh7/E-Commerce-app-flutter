import 'package:ecommerce_app/data/repositories/user/user_repository.dart';
import 'package:ecommerce_app/features/authentication/screens/login/login.dart';
import 'package:ecommerce_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce_app/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce_app/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      /// Local storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  /* -------------------------------- Email and password sign-in --------------------------------*/
// Email Authentication (Login)
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

// Email authentication (Register)
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

  // Email authentication (Mail verificatioin)
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

// Reauthenticate (Reauthenticate user)
  Future<void> reAuthenticateWithEmailAndPasswordUser(
      String email, String password) async {
    try {
      // Create credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // Re authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

// Email authentication (Forget password)

  Future<void> sendPasswordResetMail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

/* ----------------------------- Federated identity and social sign-in -----------------------*/

// Google authentication (Google)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // create a new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the userCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

// Facebook authentication (Facebook)

// LogoutUser - valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }

// Delete user - remove user auth and firestore account

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions (e.g., invalid email, user already exists)
      throw e.message.toString(); // You can customize the error message here
    } on FirebaseException catch (_) {
      // Handle other Firebase-related exceptions
      throw 'Something went wrong. Please try again!';
    } on FormatException catch (_) {
      // Handle format-related exceptions (e.g., invalid email format)
      throw 'Invalid email or password format. Please check your input.';
    } on PlatformException catch (_) {
      // Handle platform-specific exceptions (e.g., network issues)
      throw 'Network error. Please check your internet connection.';
    } catch (_) {
      // Handle any other unexpected exceptions
      throw 'An unexpected error occurred. Please try again later.';
    }
  }
}
