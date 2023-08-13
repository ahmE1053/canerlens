// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      sendToFcmToken: json['sendToFcmToken'] as String,
      currentFcmToken: json['currentFcmToken'] as String? ?? '',
      senderName: json['senderName'] as String,
      receiverName: json['receiverName'] as String,
      messageId: json['messageId'] as String,
      doctorId: json['doctorId'] as String,
      createdAt: json['createdAt'] as int,
      senderImageUrl: json['senderImageUrl'] as String?,
      fromDoctor: json['fromDoctor'] as bool,
      messageRead: json['messageRead'] as bool,
      chatMessage:
          Message.fromJson(json['chatMessage'] as Map<String, dynamic>),
      receiverImageUrl: json['receiverImageUrl'] as String,
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'sendToFcmToken': instance.sendToFcmToken,
      'currentFcmToken': instance.currentFcmToken,
      'senderName': instance.senderName,
      'receiverName': instance.receiverName,
      'messageId': instance.messageId,
      'doctorId': instance.doctorId,
      'createdAt': instance.createdAt,
      'senderImageUrl': instance.senderImageUrl,
      'fromDoctor': instance.fromDoctor,
      'messageRead': instance.messageRead,
      'chatMessage': instance.chatMessage.toJson(),
      'receiverImageUrl': instance.receiverImageUrl,
    };

_$_ChatInfo _$$_ChatInfoFromJson(Map<String, dynamic> json) => _$_ChatInfo(
      chatId: json['chatId'] as String,
      sendToFcmToken: json['sendToFcmToken'] as String,
      currentFcmToken: json['currentFcmToken'] as String? ?? '',
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      senderImageUrl: json['senderImageUrl'] as String?,
      senderName: json['senderName'] as String,
      receiverName: json['receiverName'] as String,
      receiverImageUrl: json['receiverImageUrl'] as String,
    );

Map<String, dynamic> _$$_ChatInfoToJson(_$_ChatInfo instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'sendToFcmToken': instance.sendToFcmToken,
      'currentFcmToken': instance.currentFcmToken,
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'senderImageUrl': instance.senderImageUrl,
      'senderName': instance.senderName,
      'receiverName': instance.receiverName,
      'receiverImageUrl': instance.receiverImageUrl,
    };

_$_LastMessage _$$_LastMessageFromJson(Map<String, dynamic> json) =>
    _$_LastMessage(
      lastMessage: json['lastMessage'] as String,
      numberOfUnreadMessages: json['numberOfUnreadMessages'] as int,
      fromDoctor: json['fromDoctor'] as bool,
    );

Map<String, dynamic> _$$_LastMessageToJson(_$_LastMessage instance) =>
    <String, dynamic>{
      'lastMessage': instance.lastMessage,
      'numberOfUnreadMessages': instance.numberOfUnreadMessages,
      'fromDoctor': instance.fromDoctor,
    };
