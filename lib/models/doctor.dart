import 'package:uuid/uuid.dart';

class Doctor {
  final String name;
  final String id;
  final String speciality;
  final String phoneNumber;
  final String department;

  Doctor(
      {required this.name,
      required this.speciality,
      required this.phoneNumber,
      required this.department})
      : id = Uuid().v4();
}
