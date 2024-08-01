import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final items = FirebaseFirestore.instance.collection('Items');
  final userData = FirebaseFirestore.instance.collection('Users');
  final receipients = FirebaseFirestore.instance.collection('Recipients');

//userdata collection
  Future<void> updateUserData(
      {required String name,
      required String phone,
      required String email}) async {
    await userData
        .doc(uid)
        .set({"name": name, "email": email, "phone": phone, "uid": uid});
  }

//Image upload into storage
  Future<String?> uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef =
          storageRef.child('images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = imageRef.putFile(imageFile);
      await uploadTask;
      return await imageRef.getDownloadURL();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//items Collection
  Future<void> storeItemData(String name, String description, String expiryDate,
      String imageUrl) async {
    try {
      await items.add({
        'name': name,
        'description': description,
        'expiryDate': expiryDate,
        'imageUrl': imageUrl,
        'uid': uid
      });
    } catch (e) {
      print(e.toString());
    }
  }

//Recipients Collection
  Future<void> storeRecipients({
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    try {
      await receipients.add({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        "uid": uid
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
