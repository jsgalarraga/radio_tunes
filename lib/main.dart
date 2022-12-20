import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/features/radios_list/view/radio_tuner_page.dart';
import 'package:radio_app/utils/colors.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(radioPlayerProvider.notifier).initialize();
  }

  @override
  void dispose() {
    ref.read(radioPlayerProvider.notifier).stopAndDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio App',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: AppColors.backgroundColor),
      ),
      home: const RadioTunerPage(),
    );
  }
}
