import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/doctors_list_item.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/screens/admin/add_doctors_form.dart';
import 'package:meditap/screens/scan_screen.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_style.dart';
import 'package:provider/provider.dart';

class DoctorsListScreen extends StatelessWidget {
  const DoctorsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorProvider =
        Provider.of<DoctorFormProvider>(context, listen: true);
    doctorProvider.getDoctors();
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
        itemCount: doctorProvider.doctorList.length,
        itemBuilder: (context, index) {
          return DoctorsListItem(doctor: doctorProvider.doctorList[index]);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ScanPage()));
                },
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
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AddDoctorsForm()));
                },
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
                  child: Center(
                    child: Text(
                      'Add a Doctor',
                      style: f16_w600_p500.copyWith(
                        color: primary500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
