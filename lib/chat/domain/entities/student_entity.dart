import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final int t_id;
  final String std_name;
  final String std_email;
  final String std_password;
  final int std_phone;
  final int isOnline;
  final int std_record;
  final String status;
  final int std_gander;
  final String std_image;
  final String std_date_school;
  final int batch_id;

  StudentEntity({
    this.t_id = 0,
    this.std_name = "username",
    this.std_email = "",
    this.std_password = "",
    this.std_phone = 0,
    this.isOnline = 0,
    this.std_record = 0,
    this.status = "",
    this.std_gander = 0,
    this.std_image = "",
    this.std_date_school = "",
    this.batch_id = 1,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        t_id,
        std_name,
        std_email,
        std_password,
        std_phone,
        isOnline,
        std_record,
        status,
        std_gander,
        std_image,
        std_date_school,
        batch_id,
      ];
}
