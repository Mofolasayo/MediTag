import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/constants.dart';
import 'package:meditap/utils/icons.dart';

class HowToUse extends StatelessWidget {
  const HowToUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: SvgPicture.string(MediTagIcons.blueBackIcon)),
        ),
        leadingWidth: 55,
        title: const Text(
          'How to use',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: shade0),
        ),
        centerTitle: false,
        backgroundColor: primary500,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: primary500,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: Constants.deviceHeight(context) * 0.18,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        color: blend,
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(0, 4))
                  ], color: shade0, borderRadius: BorderRadius.circular(15)),
                  height: 490,
                  width: Constants.deviceWidth(context) * 0.9,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StepTiles(
                          title: 'Step 1: Open the App',
                          subtitle:
                              'Launch the MediTag app on your phone and get started.',
                          icon: MediTagIcons.step1,
                        ),
                        StepTiles(
                          title: 'Step 2: Scan the NFC Tag',
                          subtitle:
                              'Simply hold your phone near the NFC tag provided by your doctor.',
                          icon: MediTagIcons.step2,
                        ),
                        StepTiles(
                          title: 'Step 3: Instant Information',
                          subtitle:
                              'Access your doctor\'s contact details, qualifications, specialties, and more in an instant.',
                          icon: MediTagIcons.step3,
                        ),
                        StepTiles(
                          title: 'Step 4: Access doctor\'s details',
                          subtitle:
                              'Access doctor\'s information directly to your contacts for easy hospital care.',
                          icon: MediTagIcons.step4,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class StepTiles extends StatelessWidget {
  const StepTiles({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: neutral100, width: 1))),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
              color: neutral900, fontSize: 14, fontWeight: FontWeight.w300),
        ),
        leading: SvgPicture.string(icon),
      ),
    );
  }
}
