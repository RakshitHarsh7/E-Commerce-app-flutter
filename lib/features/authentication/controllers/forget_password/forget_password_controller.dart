import 'package:ecommerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/loaders.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/network_manager.dart';
import 'package:ecommerce_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // send reset password email
  sendPasswordResetEmail() async {
    try {
      //start loading
      FullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.loadIllustration);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      // send email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetMail(email.text.trim());

      //remove loader
      FullScreenLoader.stopLoading();

      // show success screen
      Loaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link sent to reset your password'.tr);

      // Redirect
      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendpPasswordResetEmail(String email) async {

    try {
      //start loading
      FullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.loadIllustration);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      // send email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetMail(email);

      //remove loader
      FullScreenLoader.stopLoading();

      // show success screen
      Loaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link sent to reset your password'.tr);

    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
