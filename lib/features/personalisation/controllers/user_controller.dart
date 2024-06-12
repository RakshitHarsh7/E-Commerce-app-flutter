
import 'package:ecommerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_app/data/repositories/user/user_repository.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/loaders.dart';
import 'package:ecommerce_app/features/authentication/controllers/signup/network_manager.dart';
import 'package:ecommerce_app/features/authentication/screens/login/login.dart';
import 'package:ecommerce_app/features/personalisation/models/user_model.dart';
import 'package:ecommerce_app/features/personalisation/screens/profile/widgets/re-authenricate_user_login_form.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;

  final userRepository = Get.put(UserRepository());

  final profileLoading = false.obs;

  final verifyMail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  final hidePassword = false.obs;
  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fecth user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // first update Rx user and then check if user data is already stored. if not store new data
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Convert name to first name and last name
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');

          final username = UserModel.generateUserName(
              userCredential.user!.displayName ?? '');

          // Map data
          final user = UserModel(
              id: userCredential.user!.uid,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              userName: username,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '');

          // save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your profile.');
    }
  }

  // Delete account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete permanently ?',
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete'),
          ),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  // delete user account
  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing...', TImages.loadIllustration);

      // first reauthenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Re verify auth mail
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Re Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing...', TImages.loadIllustration);

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPasswordUser(
              verifyMail.text.trim(), verifyPassword.text.trim());

      await AuthenticationRepository.instance.deleteAccount();
      FullScreenLoader.stopLoading();

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        imageUploading.value = true;
        // upload image
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        // update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        Loaders.successSnackBar(
            title: 'Congratulations!',
            message: 'Your profile image has beenn updated'); 
      }
    } catch (e) {
      Loaders.errorSnackBar(
          title: 'Oh Snap!', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
