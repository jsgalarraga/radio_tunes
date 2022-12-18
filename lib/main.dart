import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_app/features/radios_list/view/radios_list_page.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const RadiosListPage(),
    );
  }
}
