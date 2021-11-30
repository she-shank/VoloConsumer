import 'package:json_annotation/json_annotation.dart';

part 'enduser.g.dart';

@JsonSerializable()
class Enduser {
  final String uID;
  final String username;
  final String userType;

  Enduser({
    required this.uID,
    required this.username,
    required this.userType,
  });

  factory Enduser.fromJson(Map<String, dynamic> json) =>
      _$EnduserFromJson(json);

  Map<String, dynamic> toJson() => _$EnduserToJson(this);
}
