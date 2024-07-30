import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/doctors_list_item.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/constants.dart';
import 'package:meditap/utils/icons.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final doctorProvider =
        Provider.of<DoctorFormProvider>(context, listen: true);
    doctorProvider.getDoctors();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: Constants.deviceWidth(context) * 0.78,
                  height: 48,
                  child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        doctorProvider.searchDoctor(value);
                      },
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: SvgPicture.string(MediTagIcons.searchIcon),
                          ),
                          prefixIconConstraints:
                              BoxConstraints.tight(const Size(30, 30)),
                          hintText: 'Search for Doctors or Specialty',
                          hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: neutral500),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: neutral100, width: 0.1))),
                      style: const TextStyle()),
                ),
                const Spacer(),
                SvgPicture.string(MediTagIcons.filterIcon)
              ],
            ),
            doctorProvider.doctorList.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: doctorProvider.doctorList.length,
                    itemBuilder: (context, index) {
                      return DoctorsListItem(
                        doctor: doctorProvider.doctorList[index],
                      );
                    },
                  )
                : Center(
                    child: SizedBox(
                      //color: Colors.red,
                      height: Constants.deviceHeight(context) * 0.7,
                      width: Constants.deviceWidth(context) * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.string(MediTagIcons.bigSearchIcon),
                          const Text(
                            'Search',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Text(
                            'Input a doctor\'s name or specialty into the field or',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: neutral500),
                          ),
                          const Text(
                            'use the filter to streamline your search.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: neutral500),
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
