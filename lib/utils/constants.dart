import 'package:flutter/material.dart';

class Constants extends StatelessWidget {
  const Constants({super.key});
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
