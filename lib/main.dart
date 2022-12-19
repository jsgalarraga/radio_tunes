import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:radio_app/features/radios_list/view/radios_list_page.dart';
import 'package:radio_app/utils/colors.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio App',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: AppColors.backgroundColor),
      ),
      home: const RadiosListPage(),
    );
  }
}
