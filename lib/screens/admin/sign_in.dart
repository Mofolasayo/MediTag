import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/pages/admin_page.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/constants.dart';
import 'package:meditap/utils/icons.dart';
import 'package:meditap/utils/text_field.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 10),
            child: SvgPicture.string(MediTagIcons.whiteBackIcon),
          ),
        ),
        backgroundColor: primary100,
        title: const Text(
          'Admin',
          style: TextStyle(color: primary700),
        ),
        centerTitle: false,
        leadingWidth: 75,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: primary100,
              height: Constants.deviceHeight(context) * 0.38,
              width: Constants.deviceWidth(context),
              child: Image.asset('assets/images/padlock.png'),
            ),
            Column(
              children: [
                SizedBox(
                  height: Constants.deviceHeight(context) * 0.34,
                  width: Constants.deviceWidth(context),
                ),
                Container(
                  height: Constants.deviceHeight(context) * 0.55,
                  width: Constants.deviceWidth(context),
                  decoration: const BoxDecoration(
                    color: shade0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                                color: neutral800,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Textfield(
                              isPassword: true,
                              label: 'Hkkfa23iejww9',
                              type: TextInputType.visiblePassword,
                              controller: _controller,
                              formKey: formKey),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: Constants.deviceWidth(context),
                            height: 48,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminPage()));
                                  }
                                },
                                child: const Text(
                                  "Sign in",
                                  style:
                                      TextStyle(color: primary50, fontSize: 16),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
