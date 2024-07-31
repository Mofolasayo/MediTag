import 'package:flutter/material.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/screens/admin/add_doctors_form.dart';
import 'package:meditap/screens/admin/doctors_list_screen.dart';
import 'package:meditap/screens/nfc_read_screen.dart';
import 'package:meditap/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/screens/admin/how_to_use.dart';
import 'package:meditap/utils/dotted_box.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/screens/scan_screen.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorProvider =
        Provider.of<DoctorFormProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AddDoctorsForm()));
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) {
                  //     return Container(
                  //       padding: const EdgeInsets.all(16),
                  //       height: 330,
                  //       width: 390,
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           SvgPicture.string(MediTagIcons.tagAdded),
                  //           const Text("Tag Added Successfully"),
                  //           const Column(
                  //             children: [
                  //               Text(
                  //                 "Your Information has been added to the Tag",
                  //                 style: TextStyle(
                  //                     fontSize: 16,
                  //                     color: neutral500,
                  //                     fontWeight: FontWeight.w400),
                  //               ),
                  //               Center(
                  //                 child: Text(
                  //                   "successfully",
                  //                   style: TextStyle(
                  //                       fontSize: 16,
                  //                       color: neutral500,
                  //                       fontWeight: FontWeight.w400),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 44,
                  //             width: 342,
                  //             child: ElevatedButton(
                  //               onPressed: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               child: const Text(
                  //                 'Done',
                  //                 style: TextStyle(
                  //                     color: primary50,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: const DottedBorderContainer(
                  child: TagOptions(
                    option: 'Add a Doctor',
                    firstLine: 'Make an addition to the',
                    secondLine: 'number of doctors',
                    icon: MediTagIcons.addIcon,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ScanReadPage()));
                },
                child: const TagOptions(
                  icon: MediTagIcons.readATag,
                  option: 'Read a Tag',
                  firstLine: 'Move near a tag to view',
                  secondLine: 'its content',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DoctorsListScreen()));
                },
                child: TagOptions(
                  option: doctorProvider.doctorList.length.toString(),
                  firstLine: 'Doctors',
                  secondLine: '',
                  icon: MediTagIcons.doctorIcon,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HowToUse()));
                },
                child: const TagOptions(
                    option: 'How to use',
                    firstLine: 'Read through our guide',
                    secondLine: 'to learn how to use',
                    icon: MediTagIcons.howToUse),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TagOptions extends StatelessWidget {
  const TagOptions({
    super.key,
    required this.option,
    required this.firstLine,
    required this.secondLine,
    required this.icon,
  });
  final String option;
  final String firstLine;
  final String secondLine;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      width: 178,
      decoration: BoxDecoration(
        border: Border.all(color: neutral100),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.string(icon),
          Text(option),
          Column(
            children: [
              Text(
                firstLine,
                style: const TextStyle(
                    color: neutral500,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                secondLine,
                style: const TextStyle(
                    color: neutral500,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
    );
  }
}
