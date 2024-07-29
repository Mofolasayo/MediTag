import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditap/screens/admin/sign_in.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/constants.dart';
import 'package:meditap/utils/icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Constants.deviceHeight(context) * 0.69,
              width: Constants.deviceWidth(context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/welcomeImage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: Constants.deviceHeight(context) * 0.37,
                  width: Constants.deviceWidth(context),
                ),
                Container(
                  height: Constants.deviceHeight(context) * 0.5,
                  width: Constants.deviceWidth(context),
                  decoration: const BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                    color: neutral50,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, right: 12.0, top: 25),
                    child: Column(
                      children: [
                        const Text(
                          "Welcome to MediTag",
                          style: TextStyle(
                              fontFamily: 'Open_Sans',
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'What are you using MediTag as?',
                          style: TextStyle(
                              color: neutral500,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: shade0,
                                border: Border.all(
                                  color: neutral100,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SizedBox(
                                height: 178,
                                width: 180,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.string(MediTagIcons.patient),
                                    const Text(
                                      'Patient',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const Column(
                                      children: [
                                        Text(
                                          'Are you looking for a',
                                          style: TextStyle(
                                              color: neutral500, fontSize: 14),
                                        ),
                                        Text(
                                          "Doctor?",
                                          style: TextStyle(
                                              color: neutral500, fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignIn()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: shade0,
                                  border: Border.all(
                                    color: neutral100,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 178,
                                width: 180,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.string(MediTagIcons.admin),
                                    const Text(
                                      'Admin',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const Column(
                                      children: [
                                        Text('Do you want to add',
                                            style: TextStyle(
                                                color: neutral500,
                                                fontSize: 14)),
                                        Text("doctors to your tag?",
                                            style: TextStyle(
                                                color: neutral500,
                                                fontSize: 14))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
