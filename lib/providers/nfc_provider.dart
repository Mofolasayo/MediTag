import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/models/doctor.dart';
import 'package:meditap/pages/admin_page.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/screens/patient_doctor_list.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class NfcProvider extends ChangeNotifier {
  List<Map<String, dynamic>> readData = [];
  bool isSessionActive = false;
  bool isScanning = false;

  String result = '';

  void _startSession() {
    isScanning = true;
    if (isSessionActive) {
      //print('Session is already active');
      return;
    }
    isSessionActive = true;
    notifyListeners();
  }

  void _stopSession({String? errorMessage}) {
    NfcManager.instance.stopSession(errorMessage: errorMessage);
    isSessionActive = false;
    isScanning = false;
    notifyListeners();
  }

  void ndefWrite(BuildContext context) async {
    bool isNfcAvailable = await NfcManager.instance.isAvailable();

    if (!isNfcAvailable) {
      isScanning = false;
      notifyListeners();
      // Show a modal sheet if NFC is not available
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'NFC is not available on this device.',
              style: TextStyle(fontSize: 18.0, color: Colors.red),
            ),
          );
        },
      );
      return;
    }
    _startSession();
    // print("Started");

    var doctorProvider =
        Provider.of<DoctorFormProvider>(context, listen: false);
    List doctorData = doctorProvider.doctorList;

    List doctorsMapList = doctorData.map((Doctor) => Doctor.toJson()).toList();
    String jsonWriteString = jsonEncode(doctorsMapList);

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);

      // print(tag.data["type"]);
      if (ndef == null || !ndef.isWritable) {
        String result = "Tag is not NDEF writable";
        _stopSession(errorMessage: result);
        return;
      }
      NdefMessage message = NdefMessage([
        NdefRecord.createMime(
            "application/json", Uint8List.fromList(jsonWriteString.codeUnits)),
      ]);
      try {
        await ndef.write(message);
        result = "successful";
        await Future.delayed(const Duration(milliseconds: 600));
        NfcManager.instance.stopSession();
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 330,
              width: 390,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.string(MediTagIcons.tagAdded),
                  const Text("Tag Added Successfully"),
                  const Column(
                    children: [
                      Text(
                        "Your Information has been added to the Tag",
                        style: TextStyle(
                            fontSize: 16,
                            color: neutral500,
                            fontWeight: FontWeight.w400),
                      ),
                      Center(
                        child: Text(
                          "successfully",
                          style: TextStyle(
                              fontSize: 16,
                              color: neutral500,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 44,
                    width: 342,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const AdminPage()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: primary50, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } catch (e) {
        String result = e.toString();
        NfcManager.instance.stopSession(errorMessage: result.toString());
      } finally {
        notifyListeners();
      }
    });
  }

  void ndefRead(BuildContext context) async {
    bool isNfcAvailable = await NfcManager.instance.isAvailable();

    if (!isNfcAvailable) {
      // Show a modal sheet if NFC is not available
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'NFC is not available on this device.',
              style: TextStyle(fontSize: 18.0, color: Colors.red),
            ),
          );
        },
      );
      return;
    }
    _startSession();

    NfcManager.instance.startSession(onDiscovered: (NfcTag Tag) async {
      var ndef = Ndef.from(Tag);

      if (ndef == null) {
        result = "Tag is not readable";
        _stopSession(errorMessage: result);
        notifyListeners();
        return;
      }
      try {
        NdefMessage message = await ndef.read();
        String jsonString = utf8.decode(message.records.first.payload);
        List<dynamic> jsonData = jsonDecode(jsonString);
        final doctors = jsonData.map((item) => Doctor.fromJson(item)).toList();
        // readData = List<dyna>.from(jsonDecode(jsonString));
        result = "Successfully read data";
        var _drProvider =
            Provider.of<DoctorFormProvider>(context, listen: false);
        for (int i = 0; i > doctors.length; i++) {
          _drProvider.doctorList.add(doctors[i]);
          notifyListeners();
        }

        //print(doctors);
        _drProvider.getDoctors();
        _stopSession();
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 330,
              width: 390,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.string(MediTagIcons.tagAdded),
                  const Text("Tag Scanned Successfully"),
                  const Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Your Information has been gotten from the Tag successfully",
                        style: TextStyle(
                            fontSize: 16,
                            color: neutral500,
                            fontWeight: FontWeight.w400),
                      ),
                      
                    ],
                  ),
                  SizedBox(
                    height: 44,
                    width: 342,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const PatientDoctorsList()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: primary50, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } catch (e) {
        result = e.toString();
        _stopSession(errorMessage: result);
      } finally {
        notifyListeners();
      }
    });
  }
}
