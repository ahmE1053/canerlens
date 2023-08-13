import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/data source/chats_remote_data_source.dart';
import '../../domain/entities/chat.dart';

@pragma('vm:entry-point')
Future<void> markMessagesAsRead(
    ChatsRemoteDataSource chatRemoteDataSource) async {
  final allChatMessages = await chatRemoteDataSource.chatRef.get();
  final filteredMessages = allChatMessages.docs.where(
    (element) => !(element.data().messageRead) && element.data().fromDoctor,
  );
  for (var message in filteredMessages) {
    final chatMessage = message.data();
    await chatRemoteDataSource.chatRef.doc(chatMessage.messageId).set(
          chatMessage.copyWith(messageRead: true),
        );
  }
}

@pragma('vm:entry-point')
Future<int> getNumberOfUnreadMessages(
    ChatsRemoteDataSource chatRemoteDataSource) async {
  final allChatMessages = await chatRemoteDataSource.chatRef.get();
  final filteredMessages = allChatMessages.docs.where(
    (element) => !(element.data().messageRead) && !element.data().fromDoctor,
  );
  return filteredMessages.length;
}

@pragma('vm:entry-point')
Future<void> handleOutsideUnreadMessages(
    ChatInfo chatInfo, LastMessage? lastMessage) async {
  if (lastMessage == null) return;
  if (!lastMessage.fromDoctor || lastMessage.numberOfUnreadMessages == 0) {
    return;
  }
  final lastMessagesRef = FirebaseFirestore.instance.collection('lastMessages');
  await lastMessagesRef.doc(chatInfo.chatId).set(
        lastMessage
            .copyWith(
              numberOfUnreadMessages: 0,
            )
            .toJson(),
      );
}

@pragma('vm:entry-point')
Future<void> handleOutsideUnreadMessagesFromChatScreen(
    ChatInfo chatInfo) async {
  final lastMessagesRef = FirebaseFirestore.instance.collection('lastMessages');
  final doc = (await lastMessagesRef.doc(chatInfo.chatId).get()).data();
  if (doc == null) return;
  final lastMessage = LastMessage.fromJson(doc);
  if (!lastMessage.fromDoctor || lastMessage.numberOfUnreadMessages == 0) {
    return;
  }
  await lastMessagesRef.doc(chatInfo.chatId).set(
        lastMessage
            .copyWith(
              numberOfUnreadMessages: 0,
            )
            .toJson(),
      );
}
