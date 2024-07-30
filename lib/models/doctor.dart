import 'package:uuid/uuid.dart';

class Doctor {
  final String name;
  final String id;
  final String specialty;
  final String phoneNumber;
  final String email;

  Doctor(
      {required this.name,
      required this.specialty,
      required this.phoneNumber,
      required this.email})
      : id = Uuid().v4();
}
