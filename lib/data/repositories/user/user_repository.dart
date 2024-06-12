import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_app/features/personalisation/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // function to save user data to firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException {
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

  // function to fetch user details based on user id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapShot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException {
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

  //function to update user data in Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException {
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

  // update any specific field in specific user collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException {
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

  //function to remove user data from Firestore
  Future<void> removeUserRecord(String UserId) async {
    try {
      await _db.collection("Users").doc(UserId).delete();
    } on FirebaseException {
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

  //Upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
      
    } on FirebaseException {
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
