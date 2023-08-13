import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/providers/lung_percentage_provider.dart';
import '../../../core/utilities/lung_dialog.dart';
import '../../../data/local_data_source/image_data_source.dart';
import '../../../generated/locale_keys.g.dart';
import '../../Widgets/analysis_widgets/select_image_button.dart';
import '../../Widgets/analysis_widgets/submit_button.dart';
import '../../Widgets/analysis_widgets/wave_widget.dart';

@RoutePage()
class LungScreen extends HookConsumerWidget {
  const LungScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = ref.watch(imgProvider);
    final mq = MediaQuery.of(context).size;
    final loading = useState(false);
    ref.watch(languageProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(builder: (context, ref, child) {
              ref.watch(languageProvider);
              return WaveWithDetailsWidget(
                mq: mq,
                icon: const FittedBox(
                  child: Icon(
                    Bootstrap.lungs,
                    color: Colors.white,
                  ),
                ),
                text: LocaleKeys.lung.tr(),
              );
            }),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageProvider.lungImg != null) ...[
                    SizedBox(
                      height: mq.height * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(
                          imageProvider.lungImg!,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  SelectImageButton(
                    mq: mq,
                    onTap: () async {
                      await ref
                          .read(imgProvider.notifier)
                          .addLungImgPath(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  SubmitButton(
                    mq: mq,
                    img: imageProvider.lungImg,
                    onTap: () async {
                      await ref
                          .read(imgProvider.notifier)
                          .runOnLungImage(context, loading);
                      final lungPercentageResults =
                          ref.read(lungPercentageProvider);
                      if (lungPercentageResults != null && context.mounted) {
                        showLungResults(
                          context,
                          lungPercentageResults,
                        );
                      }
                      ref
                          .read(lungPercentageProvider.notifier)
                          .update((state) => null);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (loading.value) const CircularProgressIndicator()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
