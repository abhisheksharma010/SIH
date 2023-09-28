// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final selectedLanguageProvider = StateProvider<Locale>((ref) => const Locale('en', ''));
//
// class LanguageNotifier extends StateNotifier<Locale> {
//   LanguageNotifier() : super(const Locale('en', ''));
//
//   void changeLanguage(Locale newLocale) {
//     state = newLocale;
//   }
// }
//
// final languageNotifierProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
//   return LanguageNotifier();
// });
//
// void changeAppLanguage(BuildContext context, Locale newLocale) {
//   context.read(languageNotifierProvider.notifier).changeLanguage(newLocale);
// }
