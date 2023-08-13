import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import 'my_text_field_widget.dart';

class EmailNamePasswordEntry extends StatelessWidget {
  const EmailNamePasswordEntry({
    super.key,
    required this.nameController,
    required this.colorScheme,
    required this.mq,
    required this.emailController,
    required this.passwordController,
    required this.obscure,
  });

  final TextEditingController nameController;
  final ColorScheme colorScheme;
  final Size mq;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueNotifier<bool> obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          label: LocaleKeys.name.tr(),
          controller: nameController,
          colorScheme: colorScheme,
          validator: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.nameEmptyError.tr();
            }
            if (value.length < 4) {
              return LocaleKeys.nameSmallError.tr();
            }
            return null;
          },
        ),
        SizedBox(height: mq.height * 0.01),
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
        ),
        SizedBox(height: mq.height * 0.01),
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
                  : Icon(Bootstrap.eye_slash,
                      key: const ValueKey(2), color: colorScheme.primary),
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
        ),
      ],
    );
  }
}
