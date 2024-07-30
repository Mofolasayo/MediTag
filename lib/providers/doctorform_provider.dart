import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meditap/models/doctor.dart';

class DoctorFormProvider with ChangeNotifier {
  String? id;
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
    this.id = id;
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

  Future<void> getDoctors() async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    doctorList = doctorBox.values.toList();
  }

  Future<void> getDoctorsFromHive() async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    doctorList = doctorBox.values.toList();

    print("Doctors Retrieved: ${doctorList.length}");
    notifyListeners();
  }

  void searchDoctor(String searchValue) {
    if (searchValue != '') {
      doctorList = doctorList.where((item) {
        return item.firstname.toLowerCase() +
                    ' ' +
                    item.lastname.toLowerCase() ==
                searchValue.toLowerCase() ||
            item.specialty.toLowerCase() == searchValue.toLowerCase();
      }).toList();
    } else {
      getDoctorsFromHive();
    }
    notifyListeners();
  }

  void addDoctorToList() {
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

    doctor.addDoctor(doctor);

    notifyListeners();
  }

  Future<void> deleteDoctor(Doctor doctor) async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    var key = doctorBox.keyAt(doctorBox.values.toList().indexOf(doctor));
    await doctorBox.delete(key);
    // Update the local list and notify listeners
    await getDoctorsFromHive();
  }

  Future<void> updateDoctorInHive(Doctor updatedDoctor) async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');

    // Find the existing doctor's key
    var existingDoctor = doctorBox.values.firstWhere(
      (doc) => doc.email == updatedDoctor.email,
    );

    print(existingDoctor.email);
    if (existingDoctor != null) {
      var key =
          doctorBox.keyAt(doctorBox.values.toList().indexOf(existingDoctor));
      await doctorBox.put(existingDoctor.id, updatedDoctor);
    } else {
      // If the doctor does not exist, you might want to handle this case
      // For example, you could add the updatedDoctor as a new entry
      await doctorBox.add(updatedDoctor);
    }

    await getDoctorsFromHive();
  }
}
