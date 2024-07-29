import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/dotted_box.dart';
import 'package:meditap/utils/icons.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DottedBorderContainer(
                child: TagOptions(
                  option: 'Add a Doctor',
                  firstLine: 'Make an addition to the',
                  secondLine: 'number of doctors',
                  icon: MediTagIcons.addIcon,
                ),
              ),
              Spacer(),
              TagOptions(
                icon: MediTagIcons.readATag,
                option: 'Read a Tag',
                firstLine: 'Move near a tag to view',
                secondLine: 'its content',
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TagOptions(
              option: 'How to use',
              firstLine: 'Read through our guide',
              secondLine: 'to learn how to use',
              icon: MediTagIcons.howToUse)
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
