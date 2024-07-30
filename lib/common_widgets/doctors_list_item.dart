import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meditap/models/doctor.dart';
import 'package:meditap/screens/admin/doctor_bio_schedule.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/text_style.dart';

class DoctorsListItem extends StatelessWidget {
  final Doctor doctor;
  const DoctorsListItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => DoctorInfo(doctor: doctor)));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: shade0,
          border: Border.symmetric(
              horizontal: BorderSide(width: 0.3, color: neutral100)),
        ),
        // color: shade0,
        height: 70,
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: primary50,
              ),
              child: Center(
                child: Text(
                  doctor.firstname,
                  style: const TextStyle(
                    fontSize: 18,
                    color: primary600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${doctor.firstname} ${doctor.lastname}',
                  style: f16_w600_p500.copyWith(
                    color: neutral800,
                  ),
                ),
                Text(
                  doctor.specialty!,
                  style: f14_w400_n500.copyWith(color: neutral600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
