import 'package:flutter/material.dart';
import 'package:fake_meteo/pages/home_page.dart';

class MeteoApp extends StatelessWidget {
  const MeteoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //adatto il tema dei testi per un BG scuro.
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
