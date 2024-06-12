import 'package:ecommerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_app/data/repositories/user/user_repository.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/loaders.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/network_manager.dart';
import 'package:ecommerce_app/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce_app/features/personalisation/models/user_model.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //variables
  final hidePassword = true.obs; // observable for hiding/showing password
  final privacypolicy = true.obs; // observable for hiding/showing password
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // form key for form validation

  /// Signup
  void signup() async {
    try {
      /// Start loading

      FullScreenLoader.openLoadingDialog(
          'We are processsing your information...', TImages.loadIllustration);

      /// check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy
      if (!privacypolicy.value) {
        Loaders.warningSnackBar(
          title: 'Accept privacy policy',
          message:
              'In order to create account, you must have to read and accept the Privacty Policy and Terms of use',
        );
        return;
      }

      // Register user in the firebase authentication and save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save user authenticated data in the firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // remove loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Your account has been created! Verify email to continue',
      );

      // Move to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

      //show success message
    } catch (e) {
      // Remove loader
      FullScreenLoader.stopLoading();

      // show some generic error to the useer
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
