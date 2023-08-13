import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/utilities/open_maps_app.dart';
import '../../../../domain/entities/doctor.dart';
import '../../../../domain/entities/lat_lng.dart';

class MyGoogleMapWidget extends HookWidget {
  const MyGoogleMapWidget({
    super.key,
    required this.doctorClinicPosition,
    required this.doctor,
  });

  final LatLng doctorClinicPosition;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final dioRequest = useMemoized(
      () => getMap(doctor.location),
    );
    final imageData = useFuture(dioRequest);
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Builder(
        builder: (context) {
          if (imageData.data == null) {
            return Center(
              child: SpinKitDualRing(
                color: Theme.of(context).colorScheme.primary,
                size: 70,
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              openMapsApp(context, doctorClinicPosition);
            },
            child: Image.memory(
              imageData.data!,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
