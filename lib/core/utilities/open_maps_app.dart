import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../domain/entities/doctor.dart';
import '../../domain/entities/lat_lng.dart';

Future<Uint8List> getMap(ClinicLocation location) async {
  final request = await Dio().post(
    'https://maps.googleapis.com/maps/api/staticmap',
    queryParameters: {
      'zoom': '16',
      'size': '400x200',
      'markers': '${location.coordinates[0]},${location.coordinates[1]}',
      'key': 'AIzaSyAqJA8CBxogJruYT-RXok6vSX6lr3U4h0M',
    },
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );
  return request.data;
}

Future<void> openMapsApp(
    BuildContext context, LatLng doctorClinicPosition) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        LocaleKeys.openMaps.tr(),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final url = Uri(
              scheme: 'geo',
              path:
                  '${doctorClinicPosition.latitude},${doctorClinicPosition.longitude}',
              queryParameters: {
                'q':
                    '${doctorClinicPosition.latitude},${doctorClinicPosition.longitude}',
              },
            );
            if (await canLaunchUrl(url)) {
              launchUrl(url);
              if (context.mounted) context.popRoute();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.openMapsError.tr(),
                    ),
                  ),
                );
                context.popRoute();
              }
            }
          },
          child: Text(
            LocaleKeys.yes.tr(),
          ),
        ),
        TextButton(
          onPressed: () {
            context.popRoute();
          },
          child: Text(
            LocaleKeys.no.tr(),
          ),
        )
      ],
    ),
  );
}
