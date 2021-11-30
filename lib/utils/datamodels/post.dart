import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String pID;
  final String profileID;
  final String mUsername;
  final String mPhotoURL;
  final String mRating;
  final String createDT;
  final String pImageURL;
  final int pCat;
  final int likeCount;

  Post({
    required this.pID,
    required this.profileID,
    required this.mUsername,
    required this.mPhotoURL,
    required this.mRating,
    required this.createDT,
    required this.pImageURL,
    required this.pCat,
    required this.likeCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
