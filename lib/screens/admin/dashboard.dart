import 'package:flutter/material.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/text_style.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-doctors-form');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primary500,
        ),
        child: Text(
          'Dashboard',
          style: f16_w600_p500.copyWith(
            color: primary50,
          ),
        ),
      ),
    );
  }
}
