import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/providers/analysis_screen_scaffold_key.dart';
import '../../../core/providers/language_provider.dart';
import '../../../generated/locale_keys.g.dart';

@RoutePage()
class InfoScreen extends HookConsumerWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context).size;
    final browser = useMemoized(() => ChromeSafariBrowser());
    final scaffoldKey = ref.read(analysisScreenScaffoldKey);
    ref.watch(languageProvider);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Consumer(
            builder: (context, value, child) {
              value.watch(languageProvider);
              return Text(LocaleKeys.twoCancersInfo.tr());
            },
          ),
        ),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: mq.height * 0.8,
          width: mq.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.height * 0.05,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    browser.open(
                      url: Uri.parse(
                        'https://www.mayoclinic.org/diseases-conditions/lung-cancer/symptoms-causes/syc-20374620',
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff83a4d4),
                          Color(0xffb6fbff),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Consumer(builder: (context, ref, child) {
                        ref.watch(languageProvider);
                        return Text(
                          LocaleKeys.toLungInfoPage.tr(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: mq.width * 0.07,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * 0.1,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    browser.open(
                      url: Uri.parse(
                        'https://www.health.harvard.edu/topics/skin-cancer',
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff9d50bb),
                          Color(0xff6e98aa),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Consumer(builder: (context, ref, child) {
                        ref.watch(languageProvider);
                        return Text(
                          LocaleKeys.toSkinInfoPage.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mq.width * 0.07,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
