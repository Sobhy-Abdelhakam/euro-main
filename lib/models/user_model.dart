import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final int phoneNumber;
  final String? address;
  final String?membershipId;
  final String? membershipSource;
  final String? carType;
  final String? carModel;
  final String? carChars;
  final int? carNumbers;
  final int? sashaNumber;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      address: json["address"],
      carChars: json["carChars"],
      carModel: json["carModel"],
      carNumbers: json["carNumbers"],
      carType: json["carType"],
      membershipId: json["membershipId"],
      membershipSource: json["membershipSource"],
      phoneNumber: json["phoneNumber"],
      sashaNumber: json["sashaNumber"],
    );
  }

  Map<String, dynamic> get toMap => {
        "name": name,
        "address": address,
        "carChars": carChars,
        "carModel": carModel,
        "carNumbers": carNumbers,
        "carType": carType,
        "membershipId": membershipId,
        "membershipSource": membershipSource,
        "phoneNumber": phoneNumber,
        "sashaNumber": sashaNumber,
      };

  const UserModel({
     this.name,
     this.address,
     this.carChars,
     this.carModel,
     this.carNumbers,
     this.carType,
     this.membershipId,
     this.membershipSource,
    required this.phoneNumber,
     this.sashaNumber,
  });

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        address,
        membershipId,
        membershipSource,
        carType,
        carModel,
        carNumbers,
        carChars,
        sashaNumber,
      ];
}
