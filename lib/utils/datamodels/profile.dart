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
  final double mLat;
  final double mLong;
  final double mRating;
  final int totalLikeCount;
  final int reviewCount;
  final List<String>? carouselImageURLs;

  Profile({
    required this.profileID,
    required this.mID,
    required this.mUsername,
    required this.mProfileDesc,
    required this.mAddress,
    required this.mContactNumber,
    required this.mLat,
    required this.mLong,
    required this.mRating,
    required this.totalLikeCount,
    required this.reviewCount,
    this.carouselImageURLs = const <String>[],
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
