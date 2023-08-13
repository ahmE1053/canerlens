import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/utilities/fade_slide_animations_list_getter.dart';
import '../../../core/utilities/widget_helper.dart';
import '../../../core/providers/auth_provider.dart';
import '../../widgets/authentication_handling_widgets/error_dialog.dart';
import '../../widgets/authentication_handling_widgets/loading_button.dart';
import '../../widgets/authentication_handling_widgets/my_text_field_widget.dart';
import '../../../Presentation/Widgets/authentication_handling_widgets/additional_auth_methods.dart';
import '../../../core/consts/app_typography.dart';
import '../../../core/utilities/context_extensions.dart';

@RoutePage()
class SigninScreen extends HookConsumerWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1250),
    );
    final animations = getAnimations(
        controller: animationController, numOfWidgets: 5, reverse: true);
    final emailController = useTextEditingController(),
        passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final obscure = useState(true);
    final loading = useState(LoadingState.nonLoading);
    final mq = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
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
          vertical: context.height * 0.05,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: context.height * 0.65,
                child: Column(
                  children: [
                    //welcome text
                    FittedBox(
                      child: Text(
                        LocaleKeys.welcomeBack.tr(),
                        textAlign: TextAlign.center,
                        style: AppTypography.bigHeadlineSize(
                          context,
                          Colors.white,
                        ),
                      ),
                    ).wrapWithFadeAndSlide(animations[0], context),
                    const SizedBox(height: 40),
                    //email text field
                    MyTextField(
                      controller: emailController,
                      colorScheme: colorScheme,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.emptyEmailError.tr();
                        }
                        return value.isValidEmail()
                            ? null
                            : LocaleKeys.wrongEmailError.tr();
                      },
                      label: LocaleKeys.email.tr(),
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                    ).wrapWithFadeAndSlide(animations[1], context),
                    const SizedBox(height: 20),
                    //password text field
                    MyTextField(
                      label: LocaleKeys.password.tr(),
                      controller: passwordController,
                      colorScheme: colorScheme,
                      obscure: obscure.value,
                      suffix: GestureDetector(
                        onTap: () {
                          obscure.value = !obscure.value;
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: obscure.value
                              ? Icon(
                                  key: const ValueKey(1),
                                  Bootstrap.eye,
                                  color: colorScheme.primary)
                              : Icon(
                                  Bootstrap.eye_slash,
                                  key: const ValueKey(2),
                                  color: colorScheme.primary,
                                ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.emptyPasswordError.tr();
                        }
                        if (value.length < 8) {
                          return LocaleKeys.smallPasswordError.tr();
                        }
                        return null;
                      },
                    ).wrapWithFadeAndSlide(animations[1], context),
                    const SizedBox(height: 20),
                    //auth button
                    Align(
                      child: LoadingButton(
                        loading: loading,
                        mq: mq,
                        onTap: () async {
                          FocusManager.instance.primaryFocus!.unfocus();
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          loading.value = LoadingState.loading;
                          await ref
                              .read(authenticationProvider.notifier)
                              .signIn(
                                emailController.value.text,
                                passwordController.value.text,
                              );
                          if (ref
                                  .read(authenticationProvider.notifier)
                                  .errorState &&
                              context.mounted) {
                            await errorDialog(
                              ref
                                  .read(authenticationProvider.notifier)
                                  .errorText,
                              context,
                            );
                            loading.value = LoadingState.nonLoading;
                            return;
                          }
                          loading.value = LoadingState.complete;
                          await Future.delayed(
                            const Duration(milliseconds: 500),
                          );
                          if (context.mounted) {
                            context.router.replaceNamed('/home');
                          }
                        },
                        text: LocaleKeys.signin.tr(),
                      ),
                    ).wrapWithFadeAndSlide(animations[2], context),
                    const SizedBox(height: 8),
                    //forget password button
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        LocaleKeys.forgetPassword.tr(),
                        style: AppTypography.semiBodySize(
                          context,
                          context.primaryColor,
                        ),
                      ),
                    ).wrapWithFadeAndSlide(animations[3], context),
                    const SizedBox(height: 8),
                    //go to sign in screen button
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
                              AutoTabsRouter.of(context).setActiveIndex(1);
                            }
                          },
                          child: Text(
                            LocaleKeys.signUp.tr(),
                            style: AppTypography.semiBodySize(
                              context,
                              context.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ).wrapWithFadeAndSlide(animations[3], context)
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //additional methods text
                  Text(
                    LocaleKeys.orSignInWith.tr(),
                    style: AppTypography.smallSize(
                      context,
                      context.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ).wrapWithFadeAndSlide(animations[4], context),
                  const SizedBox(height: 16),
                  //additional methods button
                  SizedBox(
                    height: context.height * 0.05,
                    child: const AdditionalAuthMethodsRow(),
                  ).wrapWithFadeAndSlide(animations[4], context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
