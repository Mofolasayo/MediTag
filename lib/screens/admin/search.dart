import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/doctors_list_item.dart';
import 'package:meditap/pages/filter_modal_page.dart';
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
  void showFilterModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => FilterModal(
              sortAscending: false,
              sortDescending: false,
              selectedSpecialties: [],
            ));
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final doctorProvider =
        Provider.of<DoctorFormProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              GestureDetector(
                onTap: () {
                  showFilterModal(context);
                },
                child: SvgPicture.string(MediTagIcons.filterIcon),
              ),
            ],
          ),
          if (controller.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    'Showing results for ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: neutral500,
                    ),
                  ),
                  Text(
                    '"${controller.text}"',
                  ),
                ],
              ),
            ),
          Expanded(
            child: doctorProvider.doctorList.isNotEmpty
                ? ListView.builder(
                    itemCount: doctorProvider.doctorList.length,
                    itemBuilder: (context, index) {
                      return DoctorsListItem(
                        doctor: doctorProvider.doctorList[index],
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.string(MediTagIcons.bigSearchIcon),
                        const Text(
                          'No Doctor found',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Text(
                          'Input a doctor\'s name or specialty into the field or use the filter to streamline your search.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: neutral500,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

  
