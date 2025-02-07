import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
import 'package:smatpay/features/personalization/models/user_model.dart';
import 'package:smatpay/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:smatpay/utils/exceptions/format_exceptions.dart';
import 'package:smatpay/utils/exceptions/platform_exceptions.dart';

class TUserRepository extends GetxController {
  static TUserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firebase
  Future<void> saveUserRecord(TUserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Plaese try again';
    }
  }

  /// Function to fetch user details based on User ID
  Future<TUserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(TAuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return TUserModel.fromSnashot(documentSnapshot);
      } else {
        return TUserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Plaese try again';
    }
  }

  /// Function to update user data in Firebase.
  Future<void> updateUserDetails(TUserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Plaese try again';
    }
  }

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(TAuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Plaese try again';
    }
  }

  /// Function to remove user data from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
      await _db.collection("PaystackUsers").doc().delete();
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Plaese try again';
    }
  }

  /// Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Plaese try again';
    }
  }
}
