import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/my_textfield.dart';
import 'package:meditap/models/doctor.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/screens/admin/doctors_list_screen.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_style.dart';
import 'package:provider/provider.dart';

class EditDoctorsForm extends StatelessWidget {
  final Doctor doctor; // The original doctor object to be edited

  const EditDoctorsForm({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final doctorForm = Provider.of<DoctorFormProvider>(context);

    // Initialize the form fields with the doctor details
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorForm.setInitialValues(
        doctor.firstname,
        doctor.lastname,
        doctor.specialty,
        doctor.gender,
        doctor.bio,
        doctor.phoneNumber,
        doctor.email,
        doctor.schedule,
      );
    });

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
              'Edit Doctor',
              style: f18_w400_n800,
            ),
            Text(
              'Preview',
              style: f16_w600_p500,
            ),
          ],
        ),
        centerTitle: false,
        leadingWidth: 75,
      ),
      body: SingleChildScrollView(
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
                          hint: 'First Name',
                          label: 'First Name',
                          initialValue: doctorForm.firstName,
                          onChanged: (value) =>
                              doctorForm.updateFirstName(value),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: MyTextfield(
                          hint: 'Last Name',
                          label: 'Last Name',
                          initialValue: doctorForm.lastName,
                          onChanged: (value) =>
                              doctorForm.updateLastName(value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hint: 'Select Specialty',
                    label: 'Specialty',
                    hasDropdown: true,
                    title: "Select doctor's specialty",
                    options: const [
                      'Anesthesiologist',
                      'Neurologist',
                      'Cardiologist',
                      'Dentist',
                      'Optician',
                      'Surgeon',
                    ],
                    initialValue: doctorForm.specialty,
                    onChanged: (value) => doctorForm.updateSpecialty(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hint: 'Select Gender',
                    label: 'Gender',
                    hasDropdown: true,
                    options: const ['Male', 'Female'],
                    initialValue: doctorForm.gender,
                    onChanged: (value) => doctorForm.updateGender(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hint: 'Write a short bio for the doctor',
                    label: 'Bio',
                    maxLines: 4,
                    initialValue: doctorForm.bio,
                    onChanged: (value) => doctorForm.updateBio(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hint: '+234',
                    label: 'Phone Number',
                    initialValue: doctorForm.phoneNumber,
                    onChanged: (value) => doctorForm.updatePhoneNumber(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hint: 'sample@site.com',
                    label: 'Email Address',
                    initialValue: doctorForm.emailAddress,
                    onChanged: (value) => doctorForm.updateEmailAddress(value),
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hint: 'Select Schedule',
                    label: 'Schedule',
                    title: 'Choose Available times',
                    hasDropdown: true,
                    options: const [
                      'Monday; 9:00am - 5:00pm',
                      'Tuesday; 9:00am - 5:00pm',
                      'Wednesday; 9:00am - 5:00pm',
                      'Thursday; 9:00am - 5:00pm',
                      'Friday; 9:00am - 5:00pm',
                      'Saturday; 9:00am - 5:00pm',
                      'Sunday; 9:00am - 5:00pm'
                    ],
                    isMultipleSelection: true,
                    initialValue: doctorForm.schedule?.join(', '),
                    onChangedMultiple: (values) =>
                        doctorForm.updateSchedule(values),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        final updatedDoctor = Doctor(
                          firstname: doctorForm.firstName ?? '',
                          lastname: doctorForm.lastName ?? '',
                          specialty: doctorForm.specialty ?? '',
                          gender: doctorForm.gender ?? '',
                          bio: doctorForm.bio ?? '',
                          phoneNumber: doctorForm.phoneNumber ?? '',
                          email: doctorForm.emailAddress ?? '',
                          schedule: doctorForm.schedule ?? [],
                        );
                        print('updated doctor');
                        print(updatedDoctor.toJson());

                        doctorForm.updateDoctor(doctor, updatedDoctor);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => DoctorsListScreen()),
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
