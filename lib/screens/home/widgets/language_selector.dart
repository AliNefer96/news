// import 'package:flutter/material.dart';
// import 'package:news/main.dart';

// class LanguageSelectorWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<Locale>(
//       value: MyApp.of(context)?.currentLocale ?? Locale('en'), 
//       icon: Icon(Icons.language, color: Colors.white), 
//       underline: SizedBox(), 
//       dropdownColor: Colors.white,
//       items: [
//         DropdownMenuItem(
//           child: Text("English"),
//           value: Locale('en'),
//         ),
//         DropdownMenuItem(
//           child: Text("Hrvatski"),
//           value: Locale('hr'),
//         ),
//       ],
//       onChanged: (Locale? locale) {
//         if (locale != null) {
//           MyApp.of(context)?.setLocale(locale);
//         }
//       },
//     );
//   }
// }
