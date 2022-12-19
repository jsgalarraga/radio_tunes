import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:radio_app/domain/provider/providers.dart';
import 'package:radio_app/utils/colors.dart';

class RadiosListErrorBody extends ConsumerWidget {
  const RadiosListErrorBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'An unknown error ocurred.\n\nPlease try again. If the error persists, contact customer support.',
            style: TextStyle(color: AppColors.foregroundColor, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const Gap(24),
          ElevatedButton(
            onPressed: () {
              ref.read(radiosListProvider.notifier).resetAndFetch();
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(AppColors.secondaryColor),
            ),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
