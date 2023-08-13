import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import 'sign_in_card.dart';
import '../../../core/utilities/context_extensions.dart';

class AdditionalAuthMethodsRow extends StatelessWidget {
  const AdditionalAuthMethodsRow({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 20),
        SigninCard(
          icon: EvaIcons.google,
          iconColor: context.primaryColor,
          backgroundColor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(width: 20),
        SigninCard(
          iconColor: context.primaryColor,
          backgroundColor: Colors.white,
          icon: EvaIcons.facebook,
          onTap: () {},
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
