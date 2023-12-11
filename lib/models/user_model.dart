import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';
@JsonSerializable()
class UserModel {

  @JsonKey(ignore: true)
  late String? id;
  late String firstName;
  late String lastName;
  late String email;
  late String profilePicture;


  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture
  });
  String get fullName => '$firstName $lastName' ;
  static List<String> nameParts(fullName)=>fullName.split(" ");

  //FromJSon
  factory UserModel.fromJson(Map<String,dynamic> map)=> _$UserModelFromJson(map);

  Map< String, dynamic> toJson() => _$UserModelToJson(this);


}
