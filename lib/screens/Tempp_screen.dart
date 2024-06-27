// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';

// class MyWidget extends StatefulWidget {
//   // @overrid
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   bool showBanner = false;

//   void toggleBanner() {
//     setState(() {
//       showBanner = !showBanner;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Material Banner Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: toggleBanner,
//           child: Text(showBanner ? 'Hide Banner' : 'Show Banner'),
//         ),
//       ),
//       floatingActionButton: showBanner
//           ? FloatingActionButton(
//               onPressed: toggleBanner,
//               child: Icon(Icons.close),
//             )
//           : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       // ScaffoldMessenger for showing and hiding the banner
//       bottomSheet: showBanner
//           ? MaterialBanner(
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               forceActionsBelow: true,
//               content: AwesomeSnackbarContent(
//                 title: 'Oh Hey!!',
//                 message: "Resume download process is complete !",
//                 contentType: ContentType.success,
//                 inMaterialBanner: true,
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: toggleBanner,
//                   child: Text('Dismiss'),
//                 ),
//               ],
//             )
//           : null,
//     );
//   }
// }
