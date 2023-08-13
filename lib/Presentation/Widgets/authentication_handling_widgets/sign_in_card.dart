import 'package:flutter/material.dart';

class SigninCard extends StatelessWidget {
  const SigninCard({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
    required this.iconColor,
  });

  final Color backgroundColor, iconColor;
  final IconData icon;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(1000),
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 3,
                blurStyle: BlurStyle.normal,
                offset: Offset(0, 1)),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: FittedBox(
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
