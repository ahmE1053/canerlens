import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../core/utilities/duration_converter.dart';
import '../../../../core/utilities/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../domain/entities/doctor.dart';

class OngoingCallerInfoWidget extends StatelessWidget {
  const OngoingCallerInfoWidget({
    super.key,
    required this.doctor,
    required this.callDuration,
  });

  final Doctor doctor;
  final Duration callDuration;
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
          Text(
            formatDurationForCall(callDuration),
            style: AppTypography.smallSize(
              context,
              Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
