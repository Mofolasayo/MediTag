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

  getDoctors() async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    doctorList = doctorBox.values.map((item) => item).toList();
  }

  getDoctorsFromHive() async {
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    doctorList = doctorBox.values.map((item) => item).toList();
    notifyListeners();
  }

  searchDoctor(String searchValue) {
    if (searchValue != '') {
      doctorList = doctorList.where((item) {
        return item.firstname.toLowerCase() +
                    ' ' +
                    item.lastname.toLowerCase() ==
                searchValue.toLowerCase() ||
            item.specialty.toLowerCase() == searchValue.toLowerCase();
      }).toList();
    } else {
      return doctorList;
    }
    notifyListeners();
  }

  filterDoctor(
    sortAscending,
    sortDescending,
    List<String> selectedSpecialties,
  ) {
    if (selectedSpecialties.isEmpty) {
      getDoctorsFromHive();
    } else {
      doctorList = doctorList.where((item) {
        return selectedSpecialties.contains(item.specialty);
      }).toList();
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

    getDoctorsFromHive();

    notifyListeners();
  }

  void updateDoctor(Doctor oldDoctor, Doctor doctor) async {
    print(oldDoctor.toJson());
    var doctorBox = await Hive.openBox<Doctor>('docBox');
    print(doctorBox.toMap());

    var key = doctorBox.keyAt(doctorBox.values.toList().indexOf(oldDoctor));
    await doctorBox.delete(key);

    print(doctorBox.toMap());
    // Update the local list and notify listeners
    doctor.addDoctor(doctor);

    await getDoctorsFromHive();
    print(doctorBox.toMap());
  }
}
