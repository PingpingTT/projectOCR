class PassportEntity {
  final String passportID;
  final String nameEn;
  final String Nationality;
  final String Dateofbirth;
  final String Dateofissue; //วันออกบัตร
  final String Dateofexpiry; //วันหมดอายุบัตร

  PassportEntity({
    required this.passportID,
    required this.nameEn,
    required this.Nationality,
    required this.Dateofbirth,
    required this.Dateofissue, //วันออกบัตร
    required this.Dateofexpiry, //วันหมดอายุบัตร
  });
  factory PassportEntity.empty() {
    return PassportEntity(
      passportID: '',
      nameEn: '',
      Nationality: '',
      Dateofbirth: '',
      Dateofissue: '',
      Dateofexpiry: '',
    );
  }
}
