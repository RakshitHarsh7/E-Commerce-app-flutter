import 'package:ecommerce_app/data/repositories/user/user_repository.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/loaders.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/network_manager.dart';
import 'package:ecommerce_app/features/personalisation/controllers/user_controller.dart';
import 'package:ecommerce_app/features/personalisation/screens/profile/profile.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //start loading
      FullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImages.loadIllustration);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // update users first and last namein the firebase store
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      // update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //remove loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
          title: 'Congratulations!',
          message: 'Your name has been updated successfully');

      // move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
