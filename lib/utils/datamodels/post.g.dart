// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      pID: json['pID'] as String,
      profileID: json['profileID'] as String,
      mUsername: json['mUsername'] as String,
      mPhotoURL: json['mPhotoURL'] as String,
      mRating: json['mRating'] as String,
      createDT: json['createDT'] as String,
      pImageURL: json['pImageURL'] as String,
      pCat: json['pCat'] as int,
      likeCount: json['likeCount'] as int,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'pID': instance.pID,
      'profileID': instance.profileID,
      'mUsername': instance.mUsername,
      'mPhotoURL': instance.mPhotoURL,
      'mRating': instance.mRating,
      'createDT': instance.createDT,
      'pImageURL': instance.pImageURL,
      'pCat': instance.pCat,
      'likeCount': instance.likeCount,
    };
