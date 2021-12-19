import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String profileID;
  final String mID;
  final String mUsername;
  final String mProfileDesc;
  final String mAddress;
  final String mContactNumber;
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint mGeoPoint;
  final double mRating;
  final int totalLikeCount;
  final int reviewCount;
  final List<String>? carouselImageURLs;

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  Profile({
    required this.profileID,
    required this.mID,
    required this.mUsername,
    required this.mProfileDesc,
    required this.mAddress,
    required this.mContactNumber,
    required this.mGeoPoint,
    required this.mRating,
    required this.totalLikeCount,
    required this.reviewCount,
    this.carouselImageURLs = const <String>[],
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
