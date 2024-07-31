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

  factory Doctor.fromMap(Map<String?, dynamic> data) {
    return Doctor(
      firstname: data["firstname"],
      lastname: data["lastname"],
      email: data["email"],
      bio: data['bio'],
      specialty: data["specialty"],
      phoneNumber: data["phoneNumber"],
      gender: data["gender"],
      schedule: data["schedule"],
    );
  }
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      gender: json['gender'],
      bio: json['bio'],
      specialty: json['specialty'],
      phoneNumber: json['phoneNumber'],
      schedule: List<String>.from(json['schedule']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'gender': gender,
      'bio': bio,
      'specialty': specialty,
      'phoneNumber': phoneNumber,
      'schedule': schedule,
    };
  }

  Future<void> addDoctor(Doctor doctor) async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    await doctorBox.put(doctor.id, doctor);

    print('success');
  }
}
