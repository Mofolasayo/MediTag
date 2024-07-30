import 'package:flutter/material.dart';
import 'package:meditap/screens/admin/doctors_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/common_widgets/my_textfield.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_style.dart';
import 'package:meditap/providers/doctorform_provider.dart';

class AddDoctorsForm extends StatefulWidget {
  const AddDoctorsForm({super.key});

  @override
  State<AddDoctorsForm> createState() => _AddDoctorsFormState();
}

class _AddDoctorsFormState extends State<AddDoctorsForm> {
  final _formKey = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final specialityController = TextEditingController();
  final genderController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final scheduleController = TextEditingController();

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    specialityController.dispose();
    genderController.dispose();
    bioController.dispose();
    phoneController.dispose();
    emailController.dispose();
    scheduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorForm = Provider.of<DoctorFormProvider>(context);

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
        child: Column(
          children: [
            Container(height: 20, color: neutral50),
            Form(
              key: _formKey,
              child: Container(
                color: shade0,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: MyTextfield(
                            controller: fnameController,
                            hint: 'First Name',
                            label: 'First Name',
                            keyType: TextInputType.name,
                            onChanged: (value) =>
                                doctorForm.updateFirstName(value),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: MyTextfield(
                            controller: lnameController,
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
                      controller: specialityController,
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
                      controller: genderController,
                      hint: 'Select Gender',
                      label: 'Gender',
                      keyType: TextInputType.text,
                      hasDropdown: true,
                      options: const ['Male', 'Female'],
                      onChanged: (value) => doctorForm.updateGender(value),
                    ),
                    const SizedBox(height: 16),
                    MyTextfield(
                      controller: bioController,
                      hint: 'Write a short bio for the doctor',
                      label: 'Bio',
                      keyType: TextInputType.text,
                      maxLines: 4,
                      onChanged: (value) => doctorForm.updateBio(value),
                    ),
                    const SizedBox(height: 16),
                    MyTextfield(
                      controller: phoneController,
                      hint: '+234',
                      label: 'Phone Number',
                      keyType: TextInputType.phone,
                      onChanged: (value) => doctorForm.updatePhoneNumber(value),
                    ),
                    const SizedBox(height: 16),
                    MyTextfield(
                      controller: emailController,
                      hint: 'sample@site.com',
                      label: 'Email Address',
                      keyType: TextInputType.emailAddress,
                      onChanged: (value) =>
                          doctorForm.updateEmailAddress(value),
                    ),
                    const SizedBox(height: 16),
                    MyTextfield(
                      controller: scheduleController,
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
                          if (_formKey.currentState!.validate()) {
                            doctorForm.addDoctorToList();
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
                                      SvgPicture.string(
                                          MediTagIcons.doctorAdded),
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
                                                      DoctorsListScreen()));
                                        },
                                        child: const Text('Done'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            print('bad');
                          }
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
            ),
          ],
        ),
      ),
    );
  }
}
