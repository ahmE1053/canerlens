import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../../domain/entities/chat.dart';

List<ChatMessage> filterChatMessages(
    AsyncSnapshot<QuerySnapshot<ChatMessage>> messagesStream) {
  final messages = messagesStream.data!.docs.map(
    (e) => e.data(),
  );
  //this is used to filter the messages and return only the message that
  //have successfully been uploaded from the other side or
  //the local message that are still uploading from this side
  final filteredMessages = List<ChatMessage>.from(
    messages.where(
      (message) {
        final chatMessage = message.chatMessage;

        if (chatMessage is TextMessage) {
          return true;
        }
        if (chatMessage.metadata!['type'] == 'online') {
          return true;
        }
        if (chatMessage.author.id == FirebaseAuth.instance.currentUser!.uid) {
          return true;
        }
        return false;
      },
    ),
  );

  return filteredMessages;
}

// get chat package messages from my own defined messages
List<Message> getMessageFromChatMessage(List<ChatMessage> messages) {
  return messages.map((e) => e.chatMessage).toList();
}
