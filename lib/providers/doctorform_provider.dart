import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meditap/models/doctor.dart';

class DoctorFormProvider with ChangeNotifier {
  String? firstName;
  String? lastName;
  String? specialty;
  String? gender;
  String? bio;
  String? phoneNumber;
  String? emailAddress;
  List<String>? schedule;

  DoctorFormProvider() {
    getDoctorsFromHive();
  }

  List<Doctor> doctorList = [];

  void setInitialValues(
    String? firstName,
    String? lastName,
    String? specialty,
    String? gender,
    String? bio,
    String? phoneNumber,
    String? emailAddress,
    List<String>? schedule,
  ) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.specialty = specialty;
    this.gender = gender;
    this.bio = bio;
    this.phoneNumber = phoneNumber;
    this.emailAddress = emailAddress;
    this.schedule = schedule;

    notifyListeners();
  }

  void updateFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void updateSpecialty(String value) {
    specialty = value;
    notifyListeners();
  }

  void updateGender(String value) {
    gender = value;
    notifyListeners();
  }

  void updateBio(String value) {
    bio = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void updateEmailAddress(String value) {
    emailAddress = value;
    notifyListeners();
  }

  void updateSchedule(List<String> values) {
    schedule = values;
    notifyListeners();
  }

  Future<void> getDoctorsFromHive() async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    doctorList = doctorBox.values.map((item) => item).toList();
    notifyListeners();
  }

  Future<void> addOrUpdateDoctor() async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');

    Doctor doctor = Doctor(
      firstname: firstName ?? '',
      lastname: lastName ?? '',
      bio: bio ?? '',
      email: emailAddress ?? '',
      gender: gender ?? '',
      phoneNumber: phoneNumber ?? '',
      schedule: schedule ?? [],
      specialty: specialty ?? '',
    );

    try {
      var existingDoctor = doctorBox.values.firstWhere(
        (doc) => doc.email == doctor.email,
      );
      var key =
          doctorBox.keyAt(doctorBox.values.toList().indexOf(existingDoctor));
      doctorBox.put(key, doctor);
    } catch (e) {
      // If the doctor doesn't exist, add a new entry
      doctorBox.add(doctor);
    }

    // Update the local list and notify listeners
    await getDoctorsFromHive();
  }

  Future<void> deleteDoctor(Doctor doctor) async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    var key = doctorBox.keyAt(doctorBox.values.toList().indexOf(doctor));
    await doctorBox.delete(key);
    // Update the local list and notify listeners
    await getDoctorsFromHive();
  }
}
