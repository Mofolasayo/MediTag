import 'package:flutter/material.dart';
import 'package:meditap/models/doctor.dart';
import 'package:meditap/screens/admin/doctor_bio_schedule.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/text_style.dart';

class DoctorsListItem extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onDelete;

  const DoctorsListItem(
      {super.key, required this.doctor, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(doctor.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete Doctor'),
              content: Text('Are you sure you want to delete this doctor?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes, Delete'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        onDelete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('${doctor.firstname} ${doctor.lastname} deleted')),
        );
      },
      background: Container(
          color: primary50,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Transform.translate(
                offset: Offset(-MediaQuery.of(context).size.width * 0.2, 0),
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
                          doctor.firstname[0],
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
                          doctor.specialty,
                          style: f14_w400_n500.copyWith(color: neutral600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ],
          )),
      child: GestureDetector(
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
                    doctor.firstname[0],
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
                    doctor.specialty,
                    style: f14_w400_n500.copyWith(color: neutral600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
