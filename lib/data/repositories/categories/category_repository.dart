import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapShot = await _db.collection('Categories').get();

      final list = snapShot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();

      return list;
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
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Upload categories to cloud Firebase
  // Future<void> uploadDummyData(List<CategoryModel> categories) async {

  //   try {
  //     // upload all the the categories along with their images
  //     final storage = Get.put(FirebaseStorage


  //   } catch (e) {
      
  //   }
  // }
}
