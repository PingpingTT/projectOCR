import 'package:project_ocr2/feture/domain/entity/id_card_entity.dart';

class IdCardModel {
  final String idCard;
  final String fullName;
  final String birthDate;
  final String issueDate;
  final String expiryDate;
  final String address;

  IdCardModel({
    required this.idCard,
    required this.fullName,
    required this.birthDate,
    required this.issueDate,
    required this.expiryDate,
    required this.address,
  });

  factory IdCardModel.fromJson(Map<String, dynamic> json) {
    print("JSON RECEIVED: $json"); // debug

    return IdCardModel(
      idCard: json['idCard']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      birthDate: json['birthDate']?.toString() ?? '',
      issueDate: json['issueDate']?.toString() ?? '',
      expiryDate: json['expiryDate']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
    );
  }

  IdCardEntity toEntity() {
    return IdCardEntity(
      idCard: idCard,
      fullName: fullName,
      birthDate: birthDate,
      address: address,
      issueDate: issueDate,
      expiryDate: expiryDate,
    );
  }
}
