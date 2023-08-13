import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/core/providers/shared_preferences_provider.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/utilities/chat_screen_messages_handler.dart';
import '../../../core/utilities/messages_read_handler.dart';
import '../../../data/data source/chats_remote_data_source.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../widgets/messages_screen_related/audio_playing/my_audio_player_widget.dart';
import '../../widgets/messages_screen_related/bottom_bar_related/main_bottom_widget.dart';
import '../../widgets/messages_screen_related/image_viewing/main_image_viewer.dart';
import '../../widgets/messages_screen_related/text_message_related/text_bubble.dart';
import '../../widgets/messages_screen_related/text_message_related/text_message.dart';
import '../../widgets/messages_screen_related/video_playing/main_player.dart';
import '../../../core/utilities/widget_helper.dart';

@RoutePage()
class ChatScreen extends HookConsumerWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final mq = MediaQuery.of(context).size;
    final chatInfo = ref.watch(chatInfoProvider);
    final chatRemoteDatasource = ref.watch(
      chatNotifierProvider,
    );
    final messagesStream = useStream(
      useMemoized(
        () => chatRemoteDatasource.chatRef
            .orderBy('createdAt', descending: true)
            .snapshots(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                chatInfo!.receiverImageUrl,
              ),
            ),
            const SizedBox(width: 8),
            Text('Dr. ${chatInfo.receiverName}'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(doctorsNotifierProvider.notifier).startCall(
                    chatInfo.patientId,
                    chatInfo.patientId,
                    chatInfo.doctorId,
                  );
              await ref
                  .read(patientRemoteDataSourceProvider.notifier)
                  .startCall(
                    chatInfo.patientId,
                    chatInfo.patientId,
                    chatInfo.doctorId,
                  );
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (!(messagesStream.hasData)) {
            return Center(
              child: SpinKitChasingDots(
                color: colorScheme.primary,
              ),
            );
          }
          handleOutsideUnreadMessagesFromChatScreen(chatInfo);
          markMessagesAsRead(chatRemoteDatasource);
          //remove any notification related to this doctor
          FlutterLocalNotificationsPlugin().cancel(chatInfo.doctorId.hashCode);
          // My defined messages
          final filteredMessages = filterChatMessages(messagesStream);
          // Chat package messages
          final chatFilteredMessages =
              getMessageFromChatMessage(filteredMessages);
          final brightness = ref.watch(themeProvider);
          return Chat(
            theme: brightness == Brightness.light
                ? const DefaultChatTheme()
                : const DarkChatTheme(),
            messages: chatFilteredMessages,
            bubbleBuilder: (child,
                    {required message, required nextMessageInGroup}) =>
                MyTextBubbleBuilder(
              nextMessageInGroup: nextMessageInGroup,
              isSender: message.author.id == chatInfo.patientId,
              child: child,
            ),
            onSendPressed: (_) {},
            customBottomWidget: MainBottomWidget(chatInfo: chatInfo),
            disableImageGallery: true,
            imageMessageBuilder: (imageMessage, {required messageWidth}) {
              return MyImageMessage(
                mq: mq,
                imageMessage: imageMessage,
              );
            },
            textMessageBuilder: (
              textMessage, {
              required messageWidth,
              required showName,
            }) {
              final chatMessage = filteredMessages
                  .where((element) => element.chatMessage == textMessage)
                  .first;
              return MyTextMessage(
                chatMessage: chatMessage,
                textMessage: textMessage,
                chatInfo: chatInfo,
              );
            },
            audioMessageBuilder: (audioMessage, {required messageWidth}) {
              return MyAudioPlayer(audioMessage: audioMessage);
            },
            videoMessageBuilder: (videoMessage, {required messageWidth}) {
              return MyVideoMessage(
                videoMessage: videoMessage,
                mq: mq,
              );
            },
            user: types.User(
              id: chatInfo.patientId,
              firstName: chatInfo.senderName,
            ),
          );
        },
      ),
    ).wrapWithKeyboardRemover.getDoctorAndPatientInfo(ref);
  }
}
