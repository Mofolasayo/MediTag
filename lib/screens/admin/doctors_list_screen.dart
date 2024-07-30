import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/doctors_list_item.dart';
import 'package:meditap/models/doctor.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_style.dart';

class DoctorsListScreen extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Alice Johnson',
      specialty: 'Cardiologist',
      phoneNumber: '+1234567890',
      email: 'alice.johnson@example.com',
    ),
    Doctor(
      name: 'Bob Smith',
      specialty: 'Neurologist',
      phoneNumber: '+1234567891',
      email: 'bob.smith@example.com',
    ),
    Doctor(
      name: 'Charlie Brown',
      specialty: 'Dentist',
      phoneNumber: '+1234567892',
      email: 'charlie.brown@example.com',
    ),
    Doctor(
      name: 'Diana Prince',
      specialty: 'Surgeon',
      phoneNumber: '+1234567893',
      email: 'diana.prince@example.com',
    ),
    Doctor(
      name: 'Evan Peters',
      specialty: 'Anesthesiologist',
      phoneNumber: '+1234567894',
      email: 'evan.peters@example.com',
    ),
  ];
  DoctorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 10),
            child: SvgPicture.string(MediTagIcons.whiteBackIcon),
          ),
        ),
        backgroundColor: shade0,
        title: Text(
          'Manage Doctors',
          style: f18_w400_n800,
        ),
        centerTitle: false,
        leadingWidth: 75,
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorsListItem(doctor: doctors[index]);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: primary500,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Write to NFC',
                      style: f16_w600_p500.copyWith(
                        color: primary50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: shade0,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: primary500,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add a Doctor',
                      style: f16_w600_p500.copyWith(
                        color: primary500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
