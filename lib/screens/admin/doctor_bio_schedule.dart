import 'package:flutter/material.dart';
import 'package:meditap/models/doctor.dart';
import 'package:meditap/screens/admin/edit_doctor_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_style.dart';
import 'package:meditap/providers/doctorform_provider.dart';

class DoctorInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doctorForm = Provider.of<DoctorFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: primary500,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.string(
                              MediTagIcons.whiteOutlineBackIcon),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                 Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => EditDoctorsForm(doctor: doctor)));
                              },
                              icon: SvgPicture.string(MediTagIcons.editIcon),
                            ),
                            const Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.string(MediTagIcons.doctorAndPatient),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${doctorForm.firstName ?? ''} ${doctorForm.lastName ?? ''}',
                        style: bodyLarge,
                      ),
                      const Icon(Icons.male_outlined,
                          color: neutral500, size: 15),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.male_outlined,
                          color: neutral500, size: 15),
                      Text(
                        doctorForm.specialty ?? '',
                        style: bodySmall.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, color: neutral500, size: 15),
                      Text(
                        doctorForm.phoneNumber ?? '',
                        style: bodySmall.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.mail, color: neutral500, size: 15),
                      Text(
                        doctorForm.emailAddress ?? '',
                        style: bodySmall.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: f14_w400_n500,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorForm.bio ?? '',
                      style: bodyLarge.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Available times',
                    style: f14_w400_n500,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: doctorForm.schedule != null
                      ? doctorForm.schedule!
                          .map((time) => _buildAvailabilityRow(
                              time.split(': ')[0], time.split(': ')[1]))
                          .toList()
                      : [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityRow(String day, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: text16.copyWith(
              color: neutral800,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: primary50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(time, style: f14_w400_n500.copyWith(color: primary700)),
          ),
        ],
      ),
    );
  }
}
