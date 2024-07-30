import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditap/providers/doctorform_provider.dart';
import 'package:meditap/screens/admin/dashboard.dart';
import 'package:meditap/utils/colors.dart';
import 'package:meditap/utils/icons.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class NfcProvider extends ChangeNotifier {
  List<Map<String, dynamic>> readData = [];
  bool isSessionActive = false;

  String result = '';

  void _startSession() {
    if (isSessionActive) {
      print('Session is already active');
      return;
    }
    isSessionActive = true;
  }

  void _stopSession({String? errorMessage}) {
    NfcManager.instance.stopSession(errorMessage: errorMessage);
    isSessionActive = false;
    notifyListeners();
  }

  void ndefWrite(BuildContext context) async {
    bool isNfcAvailable = await NfcManager.instance.isAvailable();

    if (!isNfcAvailable) {
      // Show a modal sheet if NFC is not available
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'NFC is not available on this device.',
              style: TextStyle(fontSize: 18.0, color: Colors.red),
            ),
          );
        },
      );
      return;
    }
    _startSession();

    var doctorProvider =
        Provider.of<DoctorFormProvider>(context, listen: false);
    List doctorData = doctorProvider.doctorList;

    List doctorsMapList = doctorData.map((Doctor) => Doctor.toJson()).toList();
    String jsonWriteString = jsonEncode(doctorsMapList);

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
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
        await Future.delayed(Duration(milliseconds: 600));
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
                          MaterialPageRoute(builder: (_) => Dashboard()),
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

  void ndefRead() async {
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
        readData = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
        result = "Successfully read data";
        _stopSession();
      } catch (e) {
        result = e.toString();
        _stopSession(errorMessage: result);
      } finally {
        notifyListeners();
      }
    });
  }
}
