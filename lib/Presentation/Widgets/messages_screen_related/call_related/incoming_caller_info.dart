import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../core/utilities/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../domain/entities/doctor.dart';

class CallerInfoWidget extends StatelessWidget {
  const CallerInfoWidget({
    super.key,
    required this.doctor,
    required this.opacity,
    required this.isCalling,
  });

  final Doctor doctor;
  final bool isCalling;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.height * 0.22,
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: CachedNetworkImageProvider(
                doctor.imageUrl,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Dr. ${doctor.name}',
            style: AppTypography.bodySize(context, Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(
              milliseconds: 600,
            ),
            child: Text(
              isCalling
                  ? LocaleKeys.calling.tr()
                  : LocaleKeys.incomingCall.tr(),
              style: AppTypography.smallSize(
                context,
                Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
