import 'package:university/chat/domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  StudentModel({
    int t_id = 0,
    String std_name = "username",
    String std_email = "",
    String std_password = "",
    int std_phone = 0,
    int isOnline = 0,
    int std_record = 0,
    String status = "",
    //bool std_gander = true,
    String std_image = "",
    String std_date_school = "",
    int batch_id = 1,
  }) : super(
          t_id: t_id,
          std_record: std_record,
          std_password: std_password,
          std_name: std_name,
          std_email: std_email,
          std_phone: std_phone,
          isOnline: isOnline,
          status: status,
          std_image: std_image,
          //    std_gander: std_gander,
          std_date_school: std_date_school,
          batch_id: batch_id,
        );

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        std_record: json['std_record'],
        std_password: json['std_password'],
        std_name: json['std_name'],
        std_email: json['std_email'],
        std_phone: json['std_phone'],
        isOnline: json['isOnline'],
        t_id: json['t_id'],
        status: json['status'],
        std_image: json['std_image'],
        std_date_school: json['std_date_school'],
        // std_gander: json['std_gander'],
        batch_id: json['batch_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "std_record": std_record,
      "std_password": std_password,
      'std_name': std_name,
      'std_email': std_email,
      'std_phone': std_phone,
      'isOnline': isOnline,
      't_id': t_id,
      'status': status,
      'std_image': std_image,
      'std_date_school': std_date_school,
      // 'std_gander': std_gander,
      'batch_id': batch_id,
    };
  }
// factory StudentModel.fromJson(Map<String, dynamic> json) {
//   return StudentModel(
//     name: json['name'],
//     email: json['email'],
//     phoneNumber: json['phoneNumber'],
//     isOnline: json['isOnline'],
//     uid: json['uid'],
//     status: json['status'],
//     profileUrl: json['profileUrl'],
//     dob: json['dob'],
//     gender: json['gender'],
//   );
// }

  // factory StudentModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   return StudentModel(
  //     name: snapshot.get('name'),
  //     email: snapshot.get('email'),
  //     phoneNumber: snapshot.get('phoneNumber'),
  //     isOnline: snapshot.get('isOnline'),
  //     uid: snapshot.get('uid'),
  //     status: snapshot.get('status'),
  //     profileUrl: snapshot.get('profileUrl'),
  //     dob: snapshot.get('dob'),
  //     gender: snapshot.get('gender'),
  //   );
  // }

  Map<String, dynamic> toDocument() {
    return {
      "std_record": std_record,
      "std_password": std_password,
      "std_name": std_name,
      "std_email": std_email,
      "std_phone": std_phone,
      "isOnline": isOnline,
      "t_id": t_id,
      "status": status,
      "std_image": std_image,
      "std_date_school": std_date_school,
      "std_gander": std_gander,
      "batch_id": batch_id
    };
  }
}
