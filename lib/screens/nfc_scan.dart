// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:meditap/providers/nfc_provider.dart';
// import 'package:meditap/utils/colors.dart';
// import 'package:meditap/utils/icons.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:provider/provider.dart';

// class NfcScan extends StatefulWidget {
//   const NfcScan({super.key});

//   @override
//   State<NfcScan> createState() => _NfcScanState();
// }

// class _NfcScanState extends State<NfcScan> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final nfcprovider = Provider.of<NfcProvider>(context, listen: false);
//       nfcprovider.ndefRead(context);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 60,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//               onTap: Navigator.of(context).pop,
//               child: SvgPicture.string(MediTagIcons.whiteBackIcon)),
//         ),
//         automaticallyImplyLeading: false,
//         title: SvgPicture.string(MediTagIcons.mediTapLogo),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             AvatarGlow(
//               startDelay: const Duration(milliseconds: 1000),
//               glowColor: primary500,
//               glowShape: BoxShape.circle,
//               animate: true,
//               curve: Curves.fastOutSlowIn,
//               child: const Material(
//                 elevation: 8.0,
//                 shape: CircleBorder(),
//                 color: Colors.transparent,
//                 child: CircleAvatar(
//                   backgroundImage: AssetImage('assets/images/phoneScan.png'),
//                   radius: 75.0,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 140,
//             ),
//             const Text(
//               'Still searching for NFC tag...',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               'Try moving your phone near an NFC tag to',
//               style: TextStyle(
//                   fontSize: 16, color: neutral500, fontWeight: FontWeight.w400),
//             ),
//             const Text(
//               'view doctors',
//               style: TextStyle(
//                   fontSize: 16, color: neutral500, fontWeight: FontWeight.w400),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
