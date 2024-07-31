import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/doctors_list_item.dart';
import 'package:meditap/pages/admin_page.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/screens/admin/add_doctors_form.dart';
import 'package:meditap/screens/admin/dashboard.dart';
import 'package:meditap/screens/scan_screen.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/constants.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_style.dart';
import 'package:provider/provider.dart';

class DoctorsListScreen extends StatelessWidget {
  const DoctorsListScreen({super.key});
  
  Future<bool?> showBottomConfirmationDialog(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return SizedBox(
          height: 340,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 170,
                width: Constants.deviceWidth(context),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                      bottom: Radius.circular(20.0)),
                  color: error50,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.string(MediTagIcons.bigOutlineDeleteIcon),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'You are about to delete this doctor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Are you sure you want to continue?',
                style: TextStyle(fontSize: 16, color: neutral500),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: Container(
                        height: 44,
                        width: 140,
                        alignment: Alignment.center,
                        child: const Text(
                          'Yes, Delete',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: primary500),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Container(
                        alignment: Alignment.center,
                        height: 44,
                        width: 140,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool?> showBottomDeleteSuccesful(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return SizedBox(
          height: 310,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 170,
                width: Constants.deviceWidth(context),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                  color: error50,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SvgPicture.string(MediTagIcons.bigDeleteIcon),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Doctor Deleted Successfully',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Your information has been deleted successfully',
                style: TextStyle(fontSize: 16, color: neutral500),
              ),
              const Text(
                'successfully.',
                style: TextStyle(fontSize: 14, color: neutral500),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final doctorProvider =
        Provider.of<DoctorFormProvider>(context, listen: true);
    doctorProvider.getDoctors();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AdminPage()));
          },
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
          return Dismissible(
              key: ValueKey(doctorProvider.doctorList[index].id),
              direction: DismissDirection.endToStart,
              background: Container(
                  color: error500,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.string(MediTagIcons.deleteIcon)),
              confirmDismiss: (direction) async {
                final result = await showBottomConfirmationDialog(context);
                if (result == true) {
                  doctorProvider.removeDoctor(doctorProvider.doctorList[index]);
                  // ignore: use_build_context_synchronously
                  showBottomDeleteSuccesful(context);
                  return true;
                } else {
                  return false;
                }
              },
              child: DoctorsListItem(doctor: doctorProvider.doctorList[index]));
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
                      .push(
                      MaterialPageRoute(builder: (_) => const ScanPage()));
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
