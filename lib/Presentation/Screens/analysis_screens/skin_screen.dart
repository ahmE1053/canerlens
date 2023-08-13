import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medapp4/core/utilities/widget_helper.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/providers/skin_percentage_provider.dart';
import '../../../core/utilities/skin_dialog.dart';
import '../../../data/local_data_source/image_data_source.dart';
import '../../../generated/locale_keys.g.dart';
import '../../Widgets/analysis_widgets/select_image_button.dart';
import '../../Widgets/analysis_widgets/submit_button.dart';
import '../../Widgets/analysis_widgets/wave_widget.dart';

@RoutePage()
class SkinScreen extends HookConsumerWidget {
  const SkinScreen({Key? key}) : super(key: key);

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
            Consumer(
              builder: (context, ref, child) {
                ref.watch(languageProvider);
                return WaveWithDetailsWidget(
                  mq: mq,
                  icon: FittedBox(
                    child: Image.asset(
                      'assets/images/skin-disease.png',
                    ),
                  ),
                  text: LocaleKeys.skin.tr(),
                );
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageProvider.skinImg != null) ...[
                    SizedBox(
                      height: mq.height * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(
                          imageProvider.skinImg!,
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
                          .addSkinImgPath(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  SubmitButton(
                    mq: mq,
                    img: imageProvider.skinImg,
                    onTap: () async {
                      await ref
                          .read(imgProvider.notifier)
                          .runOnSkinImage(context, loading);
                      final skinPercentageResults =
                          ref.read(skinPercentageProvider);
                      if (skinPercentageResults != null && context.mounted) {
                        showSkinResults(
                          context,
                          skinPercentageResults,
                        );
                      }
                      ref
                          .read(skinPercentageProvider.notifier)
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
    ).wrapWithKeyboardRemover;
  }
}
