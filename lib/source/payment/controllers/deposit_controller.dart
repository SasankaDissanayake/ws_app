// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class DepositController extends GetxController {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   String? ref;

//   Future<String?> getRefCode() async {
//     final snapshot = await _db
//         .collection('Client_Requests')
//         .doc(_auth.currentUser?.uid)
//         .collection('acc_crea')
//         .get();
//     final data = snapshot.docs.first.data();
//     String? code = data['name'] as String?;
//     final name = code?.split(' ');
//     ref = name![0];
//     return name[0];
//   }

//   Future<String?> uploadImageToFirebase(File imageFile) async {
//     try {
//       // Create a reference to the Firebase Storage location
//       Reference storageReference = FirebaseStorage.instance
//           .ref()
//           .child('payments/${DateTime.now().millisecondsSinceEpoch}');

//       // Upload the file to Firebase Storage
//       UploadTask uploadTask = storageReference.putFile(imageFile);

//       // Wait for the upload to complete
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

//       // Get the download URL of the uploaded image
//       String downloadURL = await taskSnapshot.ref.getDownloadURL();

//       return downloadURL;
//     } catch (e) {
//       print('Error uploading image: $e');
//       return null;
//     }
//   }

//   Future<void> pickImageAndUpload() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       File imageFile = File(image.path);
//       String? downloadURL = await uploadImageToFirebase(imageFile);

//       if (downloadURL != null) {
//         // Use the download URL to store it in your database or display the image
//         final data = {
//           'url': downloadURL,
//           'ref': ref,
//           'uid': _auth.currentUser?.uid,
//           'status': 'pending',
//         };

//         await _db.collection('Payments').doc(_auth.currentUser?.uid).set(data);

//         print('Image uploaded successfully: $downloadURL');
//       } else {
//         print('Error uploading image');
//       }
//     }
//   }

//   Stream<DocumentSnapshot> statusStream() {
//     return _db.collection('Payments').doc(_auth.currentUser?.uid).snapshots();
//   }
// }
