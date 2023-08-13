import 'package:flutter/material.dart';
import 'package:medapp4/core/utilities/context_extensions.dart';

class EndOrRejectCallButton extends StatelessWidget {
  const EndOrRejectCallButton({
    super.key,
    this.buttonKey,
    required this.withMargin,
    required this.onTap,
  });
  final bool withMargin;
  final GlobalKey? buttonKey;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: withMargin ? 22 : 0),
      child: Hero(
        tag: 'button',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Ink(
              padding: withMargin
                  ? const EdgeInsets.all(14)
                  : EdgeInsets.all(context.width * 0.02),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: const FittedBox(
                child: Icon(
                  Icons.call_end,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
