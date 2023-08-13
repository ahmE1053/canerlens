import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

class WaveWithDetailsWidget extends HookConsumerWidget {
  const WaveWithDetailsWidget({
    super.key,
    required this.mq,
    required this.text,
    required this.icon,
  });

  final Size mq;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: mq.height * 0.32,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipPath(
            clipper: ThirdWaveClipper(),
            child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ),
          ),
          ClipPath(
            clipper: SecondWaveClipper(),
            child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ),
          ),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffbe48d7),
                    Color(0xff8529d6),
                    Color(0xff512793),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.1, 0.5, 1],
                ),
              ),
              child: Center(
                child: SizedBox(
                  height: mq.height * 0.32 * 0.4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      const SizedBox(
                        width: 30,
                      ),
                      FittedBox(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.85);
    var firstStart = Offset(size.width * 0.1, size.height * 1);
    var firstEnd = Offset(size.width * 0.45, size.height * 0.85);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondFirst = Offset(size.width * 0.75, size.height * 0.7);
    var secondEnd = Offset(size.width, size.height);
    path.quadraticBezierTo(
        secondFirst.dx, secondFirst.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SecondWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.85);
    var firstStart = Offset(size.width * 0.1, size.height * 1.1);
    var firstEnd = Offset(size.width, size.height * 0.9);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    // var secondFirst = Offset(size.width * 0.8, size.height * 0.6);
    // var secondEnd = Offset(size.width, size.height);
    // path.quadraticBezierTo(
    //     secondFirst.dx, secondFirst.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ThirdWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width * 0.6, 0);
    path.lineTo(size.width * 0.4, size.height * 0.5);
    var firstStart = Offset(size.width * 0.5, size.height * 0.9);
    var firstEnd = Offset(size.width, size.height);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
