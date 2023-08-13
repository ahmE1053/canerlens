import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/data source/chats_remote_data_source.dart';
import '../../firebase_options.dart';
import 'messages_read_handler.dart';

class NotificationController {
  @pragma('vm:entry-point')
  static Future<void> onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) async {}

  @pragma('vm:entry-point')
  static Future<void> onDidReceiveLocalBackgroundNotification(
      NotificationResponse notificationResponse) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final payload = Map<String, Object>.from(
      jsonDecode(
        notificationResponse.payload!,
      ),
    );

    final chatRemoteDataSource =
        ChatsRemoteDataSource.fromNotification(payload);
    await markMessagesAsRead(chatRemoteDataSource);
    if (notificationResponse.actionId == 'reply' &&
        notificationResponse.input != null) {
      await chatRemoteDataSource.addText(
        notificationResponse.input!,
      );
    }
  }
}
