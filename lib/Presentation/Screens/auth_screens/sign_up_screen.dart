import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medapp4/Presentation/Screens/auth_screens/sign_in_screen.dart';
import 'package:medapp4/core/utilities/context_extensions.dart';
import 'package:medapp4/core/utilities/widget_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/app_typography.dart';
import '../../../core/consts/date_of_birth_consts.dart';
import '../../../core/providers/create_account_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/utilities/fade_slide_animations_list_getter.dart';
import '../../Widgets/authentication_handling_widgets/additional_auth_methods.dart';
import '../../widgets/authentication_handling_widgets/account_creation_text_fields.dart';
import '../../widgets/authentication_handling_widgets/date_of_birth_selection_row.dart';
import '../../widgets/authentication_handling_widgets/image_selection_widget.dart';
import '../../widgets/authentication_handling_widgets/loading_button.dart';

@RoutePage()
class SignupScreen extends HookConsumerWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1250),
    );
    final animations = getAnimations(
        controller: animationController, numOfWidgets: 7, reverse: true);
    final emailController = useTextEditingController(),
        passwordController = useTextEditingController(),
        nameController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final obscure = useState(true);
    final mq = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final dateOfBirth = useState(<int?>[null, null, null]);
    final daySelectionList = useState(days);
    final dateOfBirthErrorStateList = useState([false, false, false]);
    final loadingState = useState(LoadingState.nonLoading);
    ref.watch(languageProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            animationController.forward();
          },
        );
        return;
      },
      const [],
    );
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.1,
          vertical: context.height * 0.03,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: context.height * 0.8,
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        LocaleKeys.welcome.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mq.width * 0.07,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ).wrapWithFadeAndSlide(animations[0], context),
                    SizedBox(height: mq.height * 0.01),
                    const Align(child: ImageSelectionWidget())
                        .wrapWithFadeAndSlide(animations[1], context),
                    SizedBox(height: mq.height * 0.01),
                    EmailNamePasswordEntry(
                      nameController: nameController,
                      colorScheme: colorScheme,
                      mq: mq,
                      emailController: emailController,
                      passwordController: passwordController,
                      obscure: obscure,
                    ).wrapWithFadeAndSlide(animations[2], context),
                    SizedBox(height: mq.height * 0.01),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        LocaleKeys.dateOfBirth.tr(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: mq.width * 0.05,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ).wrapWithFadeAndSlide(animations[3], context),
                    SizedBox(height: mq.height * 0.01),
                    DateOfBirthSelectionRow(
                            dateOfBirthErrorStateList:
                                dateOfBirthErrorStateList,
                            mq: mq,
                            dateOfBirth: dateOfBirth,
                            daySelectionList: daySelectionList)
                        .wrapWithFadeAndSlide(animations[3], context),
                    SizedBox(height: mq.height * 0.02),
                    Align(
                      child: LoadingButton(
                        onTap: () async {
                          FocusManager.instance.primaryFocus!.unfocus();
                          loadingState.value = LoadingState.loading;
                          final result = await ref
                              .read(createAccountInfoProvider.notifier)
                              .createAccount(
                                dateOfBirth: dateOfBirth,
                                dateOfBirthErrorStateList:
                                    dateOfBirthErrorStateList,
                                formKey: formKey,
                                context: context,
                                name: nameController.value.text,
                                email: emailController.value.text,
                                password: passwordController.value.text,
                              );
                          result == 0
                              ? loadingState.value = LoadingState.complete
                              : loadingState.value = LoadingState.nonLoading;
                        },
                        text: LocaleKeys.signUp.tr(),
                        loading: loadingState,
                        mq: mq,
                      ),
                    ).wrapWithFadeAndSlide(animations[4], context),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        LocaleKeys.forgetPassword.tr(),
                        style: AppTypography.semiBodySize(
                          context,
                          context.primaryColor,
                        ),
                      ),
                    ).wrapWithFadeAndSlide(animations[5], context),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.newHere.tr(),
                          style: AppTypography.semiBodySize(
                            context,
                            Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: () async {
                            animationController.reverse();
                            await Future.delayed(
                              const Duration(milliseconds: 1250),
                            );
                            if (context.mounted) {
                              AutoTabsRouter.of(context).setActiveIndex(0);
                            }
                          },
                          child: Text(
                            LocaleKeys.signin.tr(),
                            style: AppTypography.semiBodySize(
                              context,
                              context.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ).wrapWithFadeAndSlide(animations[5], context)
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    LocaleKeys.orSignupWith.tr(),
                    style: AppTypography.smallSize(
                      context,
                      context.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ).wrapWithFadeAndSlide(animations[6], context),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: context.height * 0.05,
                    child: const AdditionalAuthMethodsRow(),
                  ).wrapWithFadeAndSlide(animations[6], context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
