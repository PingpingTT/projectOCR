import 'package:project_ocr2/feture/domain/entity/Passport_entity.dart';
class PassportModel extends PassportEntity {
  PassportModel({
    required super.passportID,
    required super.nameEn,
    required super.Nationality,
    required super.Dateofbirth,
    required super.Dateofissue, //วันออกบัตร
    required super.Dateofexpiry, //วันหมดอายุบัตร
  });

  factory PassportModel.fromAigenJson(Map<String, dynamic> json) {
    print("RAW JSON: $json");
    return PassportModel(
      passportID: json["passportID"]?["value"]?.toString() ?? "",
      nameEn: json["nameEn"]?["value"]?.toString() ?? "",
      Nationality: json["Nationality"]?["value"]?.toString() ?? "",
      Dateofbirth: json["Dateofbirth"]?["value"]?.toString() ?? "",
      Dateofissue: json["Dateofissue"]?["value"]?.toString() ?? "",
      Dateofexpiry: json["Dateofexpiry"]?["value"]?.toString() ?? "",
    );
  }
  PassportEntity toEntity() {
    return PassportEntity(
      passportID: passportID,
      nameEn: nameEn,
      Nationality: Nationality,
      Dateofbirth: Dateofbirth,
      Dateofissue: Dateofissue,
      Dateofexpiry: Dateofexpiry,
    );
  }
}
