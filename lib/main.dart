import 'package:flutter/material.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/screens/admin/doctor_bio_schedule.dart';
import 'package:meditap/screens/admin/doctors_list_screen.dart';
import 'package:meditap/screens/admin/edit_doctor_info.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meditap/models/doctor.dart';
import 'package:meditap/screens/splash_screen.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/screens/admin/add_doctors_form.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Hive
  await Hive.initFlutter();
  // Register Hive Adapter
  Hive.registerAdapter(DoctorAdapter());
  runApp(
    ChangeNotifierProvider(
      create: (context) => DoctorFormProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary500),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(249, 250, 250, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(249, 250, 250, 1),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Open_Sans',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Open_Sans',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Open_Sans',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: primary500,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: neutral400),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: neutral400),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary500),
            borderRadius: BorderRadius.circular(5.0),
          ),
          labelStyle: const TextStyle(color: neutral400),
          hintStyle: const TextStyle(color: neutral400),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.selected) ? primary500 : Colors.grey,
              width: 1,
            ),
          ),
          checkColor: WidgetStateProperty.resolveWith(
            (states) => primary500,
          ),
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected) ? primary100 : Colors.transparent,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/add-doctors-form': (context) => const AddDoctorsForm(),
        '/doctor-bio': (context) => DoctorInfo(),
        '/doctors-list': (context) => DoctorsListScreen(),
        '/edit-doctor-info': (context) => const EditDoctorsForm(),
      },
    );
  }
}
