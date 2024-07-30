import 'package:flutter/material.dart';
import 'package:meditap/screens/admin/doctors_list_screen.dart';
import 'package:meditap/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/my_textfield.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_style.dart';
import 'package:meditap/providers/doctorform_provider.dart';

class AddDoctorsForm extends StatelessWidget {
  const AddDoctorsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorForm = Provider.of<DoctorFormProvider>(context);
    final validator = Validator();
    final _formKey = GlobalKey<FormState>();

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add a Doctor',
              style: f18_w400_n800,
            ),
            // const Text(
            //   'Preview',
            //   style: TextStyle(color: primary500),
            // ),
          ],
        ),
        centerTitle: false,
        leadingWidth: 75,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(height: 20, color: neutral50),
            Container(
              color: shade0,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: MyTextfield(
                          validator: (value) =>
                              validator.validateName(value, 'First Name'),
                          hint: 'First Name',
                          label: 'First Name',
                          hasDropdown: false,
                          keyType: TextInputType.name,
                          onChanged: (value) =>
                              doctorForm.updateFirstName(value),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: MyTextfield(
                          validator: (value) =>
                              validator.validateName(value, 'Last Name'),
                          hint: 'Last Name',
                          label: 'Last Name',
                          keyType: TextInputType.name,
                          onChanged: (value) =>
                              doctorForm.updateLastName(value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    validator: (value) =>
                        validator.validateName(value, 'Specialty'),
                    hint: 'Select Specialty',
                    label: 'Specialty',
                    hasDropdown: true,
                    keyType: TextInputType.text,
                    title: "Select doctor's specialty",
                    options: const [
                      'Anesthesiologist',
                      'Neurologist',
                      'Cardiologist',
                      'Dentist',
                      'Optician',
                      'Surgeon',
                    ],
                    onChanged: (value) => doctorForm.updateSpecialty(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    validator: (value) =>
                        validator.validateName(value, 'Gender'),
                    hint: 'Select Gender',
                    label: 'Gender',
                    keyType: TextInputType.text,
                    hasDropdown: true,
                    options: const ['Male', 'Female'],
                    onChanged: (value) => doctorForm.updateGender(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    validator: (value) => validator.validateName(value, 'Bio'),
                    hint: 'Write a short bio for the doctor',
                    label: 'Bio',
                    keyType: TextInputType.text,
                    maxLines: 4,
                    onChanged: (value) => doctorForm.updateBio(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    validator: (value) => validator.validatePhoneNumber(value),
                    hint: '+234',
                    label: 'Phone Number',
                    keyType: TextInputType.phone,
                    onChanged: (value) => doctorForm.updatePhoneNumber(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    validator: validator.validateEmail,
                    hint: 'sample@site.com',
                    label: 'Email Address',
                    keyType: TextInputType.emailAddress,
                    onChanged: (value) => doctorForm.updateEmailAddress(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    validator: (value) =>
                        validator.validateName(value, 'Schedule'),
                    hint: 'Select Schedule',
                    label: 'Schedule',
                    title: 'Choose Available times',
                    hasDropdown: true,
                    options: const [
                      'Monday: 9:00am - 5:00pm',
                      'Tuesday: 9:00am - 5:00pm',
                      'Wednesday: 9:00am - 5:00pm',
                      'Thursday: 9:00am - 5:00pm',
                      'Friday: 9:00am - 5:00pm',
                      'Saturday: 9:00am - 5:00pm',
                      'Sunday: 9:00am - 5:00pm'
                    ],
                    isMultipleSelection: true,
                    onChangedMultiple: (values) =>
                        doctorForm.updateSchedule(values),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        doctorForm.addOrUpdateDoctor();
                        // Show the modal when the save button is clicked
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.string(MediTagIcons.doctorAdded),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Doctor Added successfully!',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Your Tag has been added to the MediTag app.\nYou can now add your doctors.',
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const DoctorsListScreen()));
                                    },
                                    child: const Text('Done'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary500,
                      ),
                      child: Text(
                        'Save',
                        style: f16_w600_p500.copyWith(
                          color: primary50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
