import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/utilities/image_picker.dart';
import '../../core/utilities/messages_read_handler.dart';
import '../../domain/entities/chat.dart';

class ChatsRemoteDataSource {
  final ChatInfo chatInfo;
  final storageInstance = FirebaseStorage.instance;
  final lastMessagesRef = FirebaseFirestore.instance.collection('lastMessages');
  late final CollectionReference<ChatMessage> chatRef;
  ChatsRemoteDataSource({required this.chatInfo}) {
    chatRef = FirebaseFirestore.instance
        .collection('chats/${chatInfo.patientId}/${chatInfo.chatId}')
        .withConverter<ChatMessage>(
      fromFirestore: (snapshot, options) {
        return ChatMessage.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  factory ChatsRemoteDataSource.fromNotification(Map<String, Object?> data) {
    final chatInfo = ChatInfo.fromJson(data).copyWith(
      sendToFcmToken: data['currentFcmToken'] as String,
      currentFcmToken: data['sendToFcmToken'] as String,
    );
    return ChatsRemoteDataSource(chatInfo: chatInfo);
  }

  Future<void> addVoice(
    String filePath,
    Duration duration,
  ) async {
    //creates the basic audio message variables like the id, createdAt and the
    //message variables with corresponding info like duration and path
    final messageId = const Uuid().v4();
    final createdAt = DateTime.now().millisecondsSinceEpoch;
    final audioMessage = types.AudioMessage(
      author: types.User(
        id: chatInfo.patientId,
      ),
      duration: duration,
      id: messageId,
      name: chatInfo.senderName,
      size: 0,
      uri: filePath,
      createdAt: createdAt,
    );

    final chatMessage = ChatMessage(
      senderName: chatInfo.senderName,
      receiverName: chatInfo.receiverName,
      receiverImageUrl: chatInfo.receiverImageUrl,
      fromDoctor: false,
      senderImageUrl: chatInfo.senderImageUrl,
      messageRead: false,
      currentFcmToken: chatInfo.currentFcmToken,
      doctorId: chatInfo.doctorId,
      sendToFcmToken: chatInfo.sendToFcmToken,
      messageId: messageId,
      createdAt: createdAt,
      chatMessage: audioMessage,
    );

    //uploads the voice to cloud storage then
    storageInstance
        .ref(basename(filePath))
        .putFile(File(filePath))
        .snapshotEvents
        .listen(
      (event) {
        //get the progress of the uploading process
        final sent = event.bytesTransferred;
        final total = event.totalBytes;
        final progress = sent / total;
        // if it's done then modify the firestore document to mark it as done
        //and leave the offline path in case the user still has it on their phone
        if (event.state == TaskState.success) {
          event.ref.getDownloadURL().then(
            (value) async {
              chatRef.doc(messageId).set(
                    chatMessage.copyWith(
                      chatMessage: audioMessage.copyWith(
                        uri: value,
                        metadata: {
                          'type': 'online',
                          'offlinePath': filePath,
                          'progress': 1.0,
                        },
                      ),
                    ),
                  );

              await Future.delayed(const Duration(milliseconds: 500));
              final numberOfUnreadMessages =
                  await getNumberOfUnreadMessages(this);
              await lastMessagesRef.doc(chatInfo.chatId).set(
                    LastMessage(
                      lastMessage: 'Voice Message',
                      numberOfUnreadMessages: numberOfUnreadMessages,
                      fromDoctor: false,
                    ).toJson(),
                  );
            },
          );
          return;
        }

        //if it's still uploading then show the current upload progress
        //type as offline automatically makes the app use the local file
        chatRef.doc(messageId).set(
              chatMessage.copyWith(
                chatMessage: audioMessage.copyWith(
                  metadata: {
                    'type': 'offline',
                    'offlinePath': '',
                    'progress': progress,
                  },
                ),
              ),
            );
      },
    );
  }

  Future<void> addImage(BuildContext context) async {
    final messageId = const Uuid().v4();
    final image = await imagePickerForChatScreen(context, messageId);

    if (image == null) {
      return;
    }

    final bool video = image['video']! as bool;
    final String imagePath = image['path']! as String;

    final createdAt = DateTime.now().millisecondsSinceEpoch;
    late types.Message message;
    if (video) {
      message = types.VideoMessage(
        uri: imagePath,
        metadata: const {
          'type': 'offline',
          'offlinePath': '0',
          'progress': 0.0,
        },
        author: types.User(
          id: chatInfo.patientId,
          firstName: chatInfo.senderName,
        ),
        id: messageId,
        name: chatInfo.senderName,
        createdAt: createdAt,
        size: 0,
      );
    } else {
      message = types.ImageMessage(
        uri: imagePath,
        metadata: const {
          'type': 'offline',
          'offlinePath': '0',
          'progress': 0.0,
        },
        author: types.User(
          id: chatInfo.patientId,
          firstName: chatInfo.senderName,
        ),
        id: messageId,
        name: chatInfo.senderName,
        createdAt: createdAt,
        size: 0,
      );
    }

    final chatMessage = ChatMessage(
      messageRead: false,
      fromDoctor: false,
      senderImageUrl: chatInfo.senderImageUrl,
      currentFcmToken: chatInfo.currentFcmToken,
      messageId: messageId,
      createdAt: createdAt,
      senderName: chatInfo.senderName,
      receiverName: chatInfo.receiverName,
      receiverImageUrl: chatInfo.receiverImageUrl,
      chatMessage: message,
      doctorId: chatInfo.doctorId,
      sendToFcmToken: chatInfo.sendToFcmToken,
    );

    // ???
    // await chatRef.doc(messageId).set(chatMessage);

    storageInstance
        .ref(basename(imagePath))
        .putFile(File(imagePath))
        .snapshotEvents
        .listen(
      (event) {
        final sent = event.bytesTransferred;
        final total = event.totalBytes;
        final progress = sent / total;

        if (event.state == TaskState.success) {
          event.ref.getDownloadURL().then(
            (value) async {
              chatRef.doc(messageId).set(
                    chatMessage.copyWith(
                      chatMessage: video
                          ? (message as types.VideoMessage).copyWith(
                              uri: value,
                              metadata: {
                                'type': 'online',
                                'offlinePath': imagePath,
                                'progress': 1.0,
                              },
                            )
                          : (message as types.ImageMessage).copyWith(
                              uri: value,
                              metadata: {
                                'type': 'online',
                                'offlinePath': imagePath,
                                'progress': 1.0,
                              },
                            ),
                    ),
                  );
              await Future.delayed(const Duration(milliseconds: 500));
              final numberOfUnreadMessages =
                  await getNumberOfUnreadMessages(this);
              await lastMessagesRef.doc(chatInfo.chatId).set(
                    LastMessage(
                      lastMessage: video ? 'Video Message' : 'Image Message',
                      numberOfUnreadMessages: numberOfUnreadMessages,
                      fromDoctor: false,
                    ).toJson(),
                  );
            },
          );
          return;
        }

        chatRef.doc(messageId).set(
              chatMessage.copyWith(
                chatMessage: message.copyWith(
                  metadata: {
                    'type': 'offline',
                    'offlinePath': '',
                    'progress': progress,
                  },
                ),
              ),
            );
      },
    );
  }

  Future<void> addText(String text) async {
    final messageId = const Uuid().v4();
    final createdAt = DateTime.now().millisecondsSinceEpoch;
    final message = types.TextMessage(
      author: types.User(
        id: chatInfo.patientId,
        firstName: chatInfo.senderName,
      ),
      text: text,
      createdAt: createdAt,
      id: messageId,
      metadata: const {
        'progress': 1.0,
      },
    );
    final chatMessage = ChatMessage(
      fromDoctor: false,
      senderImageUrl: chatInfo.senderImageUrl,
      messageRead: false,
      currentFcmToken: chatInfo.currentFcmToken,
      doctorId: chatInfo.doctorId,
      senderName: chatInfo.senderName,
      receiverName: chatInfo.receiverName,
      receiverImageUrl: chatInfo.receiverImageUrl,
      messageId: messageId,
      sendToFcmToken: chatInfo.sendToFcmToken,
      createdAt: createdAt,
      chatMessage: message,
    );
    await chatRef.doc(messageId).set(chatMessage);
    await Future.delayed(const Duration(milliseconds: 500));
    final numberOfUnreadMessages = await getNumberOfUnreadMessages(this);
    await lastMessagesRef.doc(chatInfo.chatId).set(
          LastMessage(
            lastMessage: text,
            numberOfUnreadMessages: numberOfUnreadMessages,
            fromDoctor: false,
          ).toJson(),
        );
  }
}

final chatNotifierProvider = Provider<ChatsRemoteDataSource>(
  (ref) => ChatsRemoteDataSource(
    chatInfo: ref.watch(chatInfoProvider)!,
  ),
);

final chatInfoProvider = StateProvider<ChatInfo?>((ref) => null);
