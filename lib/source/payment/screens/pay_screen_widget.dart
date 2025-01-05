// import 'package:app/source/payment/controllers/deposit_controller.dart';
// import 'package:app/source/references/details.dart';
// import 'package:app/source/references/local_db_manage.dart';
// import 'package:app/source/splash_screen/screens/loading_screen_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Pay extends StatelessWidget {
//   final DepositController controller = Get.put(DepositController());

//   Pay({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool isDark = Get.isDarkMode;
//     bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () => Get.back(),
//             icon: const Icon(Icons.arrow_back_ios_new)),
//       ),
//       body: SingleChildScrollView(
//         child: StreamBuilder<DocumentSnapshot>(
//           stream: controller.statusStream(),
//           builder:
//               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const LoadingScreen();
//             }

//             if (!snapshot.data!.exists) {
//               return Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 15),
//                     child: Column(
//                       children: [
//                         Text(
//                           "For now we only accept bank deposite as payment.\n",
//                           style: GoogleFonts.oswald(
//                             fontSize: 30,
//                             color: isDark ? Colors.white : Colors.black,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 0),
//                           child: Row(
//                             children: [
//                               RichText(
//                                 textAlign: TextAlign.start,
//                                 text: TextSpan(
//                                   text: '\n',
//                                   style: GoogleFonts.oswald(
//                                     fontSize: 20,
//                                   ),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                       text: "Bank details\n",
//                                       style: GoogleFonts.oswald(
//                                         fontSize: 25,
//                                         color: isDark
//                                             ? Colors.white
//                                             : Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: bankDetails,
//                                       style: GoogleFonts.oswald(
//                                         fontSize: 23,
//                                         color: isDark
//                                             ? Colors.white
//                                             : Colors.black,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         isEnglish
//                             ? Text(
//                                 "deposit".tr,
//                                 style: GoogleFonts.oswald(
//                                   fontSize: 20,
//                                   color: isDark ? Colors.white : Colors.black,
//                                 ),
//                                 textAlign: TextAlign.start,
//                               )
//                             : Text(
//                                 "deposit".tr,
//                                 style: GoogleFonts.gemunuLibre(
//                                   fontSize: 23,
//                                   color: isDark ? Colors.white : Colors.black,
//                                 ),
//                                 textAlign: TextAlign.start,
//                               ),
//                         FutureBuilder(
//                             future: controller.getRefCode(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const CircularProgressIndicator();
//                               } else {
//                                 return isEnglish
//                                     ? Text(
//                                         "When you deposting the money please put this '${snapshot.data}' as reference of the deposite. \n(With that we could easliy verify the payment)",
//                                         style: GoogleFonts.oswald(
//                                           fontSize: 20,
//                                           color: Colors.redAccent,
//                                         ),
//                                         textAlign: TextAlign.start,
//                                       )
//                                     : Text(
//                                         "Payment එක කරනකොට මතක ඇතුව '${snapshot.data}' මේ වචනය reference/reason එක හැටියට දාන්න. එත්කොට අපිට payment එක ඔයා  කරේ කියලා  verify කරන්න ලෙසියි.",
//                                         style: GoogleFonts.gemunuLibre(
//                                           fontSize: 23,
//                                           color: Colors.redAccent,
//                                         ),
//                                         textAlign: TextAlign.start,
//                                       );
//                               }
//                             }),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         ElevatedButton(
//                           onPressed: () async =>
//                               await controller.pickImageAndUpload(),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.pinkAccent,
//                             foregroundColor: Colors.white,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 10, bottom: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 const Icon(Icons.upload),
//                                 Text(
//                                   "Upload the payment slip ",
//                                   style: GoogleFonts.oswald(fontSize: 20),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             final data = snapshot.data?.data() as Map<String, dynamic>;
//             final status = data['status'];
//             String stats = status as String;
//             if (stats == 'pending') {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Column(
//                   children: [
//                     isEnglish
//                         ? Text(
//                             'wait'.tr,
//                             style: GoogleFonts.oswald(
//                               fontSize: 25,
//                               color: Colors.blueAccent,
//                             ),
//                             textAlign: TextAlign.start,
//                           )
//                         : Text(
//                             'wait'.tr,
//                             style: GoogleFonts.gemunuLibre(
//                               fontSize: 25,
//                               color: Colors.blueAccent,
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                   ],
//                 ),
//               );
//             }
//             if (stats == 'declined') {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Column(
//                   children: [
//                     Text(
//                       "We couldn't verify your payment😑.\n\nIf you have any problem please call $phoneNumber",
//                       style: GoogleFonts.oswald(
//                         fontSize: 25,
//                         color: Colors.redAccent,
//                       ),
//                       textAlign: TextAlign.start,
//                     )
//                   ],
//                 ),
//               );
//             }
//             if (stats == 'approved') {
//               Get.back();
//               Get.back();
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
