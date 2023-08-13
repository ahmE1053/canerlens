import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import 'authentication_handling_widgets/my_text_field_widget.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {this.enabled = true,
      Key? key,
      required this.controller,
      required this.colorScheme,
      required this.searchFunction,
      required this.formKey,
      required this.ref,
      required this.provider})
      : super(key: key);

  final TextEditingController controller;
  final ColorScheme colorScheme;
  final void Function() searchFunction;
  final GlobalKey<FormState> formKey;
  final WidgetRef ref;
  final StateProvider provider;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: MyTextField(
        enabled: enabled,
        controller: controller,
        colorScheme: colorScheme,
        label: LocaleKeys.search.tr(),
        suffix: IconButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            searchFunction();
            FocusManager.instance.primaryFocus!.unfocus();
          },
          icon: const Icon(
            Icons.search,
          ),
        ),
        onChanged: (value) {
          ref.read(provider.notifier).update((state) => value);
        },
        validator: (value) {
          if (value!.isEmpty || value.trim().isEmpty) {
            return LocaleKeys.searchEmptyError.tr();
          }
          if (value.length < 3) {
            return LocaleKeys.searchSmallError.tr();
          }
          return null;
        },
        inputAction: TextInputAction.search,
        onSubmitted: (value) {
          if (!formKey.currentState!.validate()) return;
          searchFunction();
          FocusManager.instance.primaryFocus!.unfocus();
        },
      ),
    );
  }
}
