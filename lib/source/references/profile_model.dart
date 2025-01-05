import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  final String userId;
  final String name;
  final String phoneNumber;
  final String fullName;
  final String promo;
  final DateTime birthday;
  final int accountFor;
  final int gender;
  final String description;
  final bool sameCasteSearch;
  final int myCaste;
  final int inch;
  final int ft;
  final int myMarraige;
  final int prefMarraige;
  final int kids;
  final List<String> qualities;
  final int district;
  final int race;
  final int religion;
  final int myEduLvel;
  final int prefEduLevl;
  final List<String> eduAchi;
  final List<String> eduPlcs;
  final String jobPos;
  final String workPlc;
  final int mySmokes;
  final int myDrinks;
  final int prefSmokes;
  final int prefDrinks;
  final List<String> imageUrls;
  final int skinColor;
  final Timestamp createdAt;

  AccountModel({
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.fullName,
    required this.promo,
    required this.birthday,
    required this.accountFor,
    required this.gender,
    required this.description,
    required this.sameCasteSearch,
    required this.myCaste,
    required this.inch,
    required this.ft,
    required this.myMarraige,
    required this.prefMarraige,
    required this.kids,
    required this.qualities,
    required this.district,
    required this.race,
    required this.religion,
    required this.myEduLvel,
    required this.prefEduLevl,
    required this.eduAchi,
    required this.eduPlcs,
    required this.jobPos,
    required this.workPlc,
    required this.mySmokes,
    required this.myDrinks,
    required this.prefSmokes,
    required this.prefDrinks,
    required this.imageUrls,
    required this.skinColor,
    required this.createdAt,
  });

  toJson() {
    return {
      'userId': userId,
      'imageUrls': imageUrls,
      'skinColor': skinColor,
      'name': name,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'promoCode': promo,
      'birthday': birthday,
      'accountFor': accountFor,
      'gender': gender,
      'description': description,
      'sameCasteSearch': sameCasteSearch,
      'myCaste': myCaste,
      'inch': inch,
      'ft': ft,
      'myMarraige': myMarraige,
      'prefMarraige': prefMarraige,
      'kids': kids,
      'qualities': qualities,
      'district': district,
      'race': race,
      'religion': religion,
      'myEduLvel': myEduLvel,
      'prefMinEduLevl': prefEduLevl,
      'eduAchi': eduAchi,
      'eduPlcs': eduPlcs,
      'createdAt': createdAt,
      'jobPos': jobPos,
      'workPlc': workPlc,
      'mySmokes': mySmokes,
      'myDrinks': myDrinks,
      'prefDrinks': prefDrinks,
      'prefSmokes': prefSmokes,
    };
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        createdAt: json['createdAt'] as Timestamp,
        userId: json['userId'] as String,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        fullName: json['fullName'] as String,
        promo: json['promoCode'] as String,
        birthday: (json['birthday'] as Timestamp).toDate(),
        accountFor: json['accountFor'] as int,
        gender: json['gender'] as int,
        description: json['description'] as String,
        sameCasteSearch: json['sameCasteSearch'] as bool,
        myCaste: json['myCaste'] as int,
        inch: json['inch'] as int,
        ft: json['ft'] as int,
        myMarraige: json['myMarraige'] as int,
        prefMarraige: json['prefMarraige'] as int,
        kids: json['kids'] as int,
        qualities: (json['qualities'] as List<dynamic>).cast<String>(),
        district: json['district'] as int,
        race: json['race'] as int,
        religion: json['religion'] as int,
        myEduLvel: json['myEduLvel'] as int,
        prefEduLevl: json['prefMinEduLevl'] as int,
        eduAchi: (json['eduAchi'] as List<dynamic>).cast<String>(),
        eduPlcs: (json['eduPlcs'] as List<dynamic>).cast<String>(),
        jobPos: json['jobPos'] as String,
        workPlc: json['workPlc'] as String,
        mySmokes: json['mySmokes'] as int,
        myDrinks: json['myDrinks'] as int,
        prefSmokes: json['prefSmokes'] as int,
        prefDrinks: json['prefDrinks'] as int,
        imageUrls: (json['imageUrls'] as List<dynamic>).cast<String>(),
        skinColor: json['skinColor'] as int,
      );
}
