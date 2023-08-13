import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../../core/consts/app_typography.dart';
import '../../../../domain/entities/chat.dart';

class MyTextMessage extends StatelessWidget {
  const MyTextMessage({
    Key? key,
    required this.textMessage,
    required this.chatInfo,
    required this.chatMessage,
  }) : super(key: key);
  final TextMessage textMessage;
  final ChatInfo chatInfo;
  final ChatMessage chatMessage;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSenderColor = colorScheme.onPrimary;
    final isReceiverColor = colorScheme.onSecondary;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: textMessage.author.id == chatInfo.doctorId
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            textMessage.text,
            style: AppTypography.semiBodySize(
              context,
              textMessage.author.id == chatInfo.doctorId
                  ? isSenderColor
                  : isReceiverColor,
            ),
          ),
          const SizedBox(height: 4),
          Builder(builder: (context) {
            if (textMessage.author.id == chatInfo.patientId) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Builder(
                    builder: (context) {
                      if (chatMessage.messageRead) {
                        return const Icon(
                          Icons.done_all,
                          color: Colors.white,
                        );
                      } else {
                        return const Icon(
                          Icons.done,
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  MessageTimeText(
                      textMessage: textMessage,
                      chatInfo: chatInfo,
                      isSenderColor: isSenderColor,
                      isReceiverColor: isReceiverColor),
                ],
              );
            }
            return MessageTimeText(
                textMessage: textMessage,
                chatInfo: chatInfo,
                isSenderColor: isSenderColor,
                isReceiverColor: isReceiverColor);
          })
        ],
      ),
    );
  }
}

class MessageTimeText extends StatelessWidget {
  const MessageTimeText({
    super.key,
    required this.textMessage,
    required this.chatInfo,
    required this.isSenderColor,
    required this.isReceiverColor,
  });

  final TextMessage textMessage;
  final ChatInfo chatInfo;
  final Color isSenderColor;
  final Color isReceiverColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.jm(
        context.locale.languageCode,
      ).format(
        DateTime.fromMillisecondsSinceEpoch(textMessage.createdAt!),
      ),
      style: AppTypography.smallSize(
        context,
        textMessage.author.id == chatInfo.doctorId
            ? isSenderColor.withOpacity(0.7)
            : isReceiverColor.withOpacity(0.7),
      ),
    );
  }
}
