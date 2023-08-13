import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medapp4/core/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/consts/app_typography.dart';
import '../../../core/utilities/messages_read_handler.dart';
import '../../../core/utilities/context_extensions.dart';
import '../../../data/data source/chats_remote_data_source.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../../domain/entities/chat.dart';

class ChatCard extends HookConsumerWidget {
  const ChatCard({Key? key, required this.lastMessage, required this.chatInfo})
      : super(key: key);
  final ChatInfo chatInfo;
  final LastMessage? lastMessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context).size;
    final doctor = ref.watch(doctorsNotifierProvider.notifier).getDoctorById(
          chatInfo.doctorId,
        );
    final patient = ref.read(
      patientRemoteDataSourceProvider,
    );
    final lastMessage = this.lastMessage;

    return Builder(
      builder: (context) {
        return ListTile(
          onTap: () async {
            handleOutsideUnreadMessages(chatInfo, lastMessage);
            ref.read(chatInfoProvider.notifier).update(
                  (state) => chatInfo.copyWith(
                    senderImageUrl: doctor.imageUrl,
                    sendToFcmToken: doctor.fcmToken,
                    currentFcmToken: patient.value!.fcmToken,
                  ),
                );
            //TODO: here
            context.router.push(
              const ChatRoute(),
            );
          },
          contentPadding: const EdgeInsets.all(16),
          leading: SizedBox(
            width: mq.width * 0.15,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: doctor.imageUrl,
                fit: BoxFit.fill,
                errorWidget: (_, __, ___) => const FittedBox(
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ),
            ),
          ),
          title: Text('Dr. ${doctor.name}'),
          subtitle: lastMessage == null
              ? null
              : Text(
                  '${!lastMessage.fromDoctor ? LocaleKeys.you.tr() : ''} ${lastMessage.lastMessage}',
                ),
          trailing: lastMessage == null
              ? null
              : lastMessage.numberOfUnreadMessages > 0 && lastMessage.fromDoctor
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.primaryColor,
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Text(
                        '${lastMessage.numberOfUnreadMessages}',
                        style: AppTypography.semiBodySize(
                          context,
                          context.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : null,
        );
      },
    );
  }
}
