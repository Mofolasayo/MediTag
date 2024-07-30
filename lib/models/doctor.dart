import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'doctor.g.dart';

@HiveType(typeId: 1)
class Doctor {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstname;
  @HiveField(2)
  final String lastname;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String gender;
  @HiveField(5)
  final String bio;
  @HiveField(6)
  final String specialty;
  @HiveField(7)
  final String phoneNumber;
  @HiveField(8)
  final List<String> schedule;

  Doctor({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.gender,
    required this.bio,
    required this.specialty,
    required this.phoneNumber,
    required this.schedule,
  }) : id = const Uuid().v4();

  Future<void> AddDoctor(Doctor doctor) async {
    var doctorBox = await Hive.openBox('doctoreBox');
    await doctorBox.put(doctor.id, doctor);

    print('success');
  }
}
