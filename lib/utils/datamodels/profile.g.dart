// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      profileID: json['profileID'] as String,
      mID: json['mID'] as String,
      mUsername: json['mUsername'] as String,
      mProfileDesc: json['mProfileDesc'] as String,
      mAddress: json['mAddress'] as String,
      mContactNumber: json['mContactNumber'] as String,
      mGeoPoint: Profile._fromJsonGeoPoint(json['mGeoPoint'] as GeoPoint),
      mRating: (json['mRating'] as num).toDouble(),
      totalLikeCount: json['totalLikeCount'] as int,
      reviewCount: json['reviewCount'] as int,
      carouselImageURLs: (json['carouselImageURLs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'profileID': instance.profileID,
      'mID': instance.mID,
      'mUsername': instance.mUsername,
      'mProfileDesc': instance.mProfileDesc,
      'mAddress': instance.mAddress,
      'mContactNumber': instance.mContactNumber,
      'mGeoPoint': Profile._toJsonGeoPoint(instance.mGeoPoint),
      'mRating': instance.mRating,
      'totalLikeCount': instance.totalLikeCount,
      'reviewCount': instance.reviewCount,
      'carouselImageURLs': instance.carouselImageURLs,
    };
