// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smartbus/provider/localProvider.dart';
// // Import your Riverpod locale provider
//
// class SettingsScreen extends StatelessWidget {
//   final StateNotifierProvider<LanguageNotifier, Locale> languageProvider;
//
//   const SettingsScreen({Key? key, required this.languageProvider}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Column(
//         children: <Widget>[
//           RadioListTile<Locale>(
//             title: Text('English'),
//             value: const Locale('en', ''),
//             groupValue: languageProvider.state,
//             onChanged: (Locale? value) {
//               if (value != null) {
//                 languageProvider.notifier.changeLanguage(value);
//               }
//             },
//           ),
//           RadioListTile<Locale>(
//             title: Text('Hindi'),
//             value: const Locale('hi', ''),
//             groupValue: languageProvider.state,
//             onChanged: (Locale? value) {
//               if (value != null) {
//                 languageProvider.notifier.changeLanguage(value);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
