import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';

part 'chat.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  @JsonSerializable(explicitToJson: true)
  const factory ChatMessage({
    required String sendToFcmToken,
    @Default('') String currentFcmToken,
    required String senderName,
    required String receiverName,
    required String messageId,
    required String doctorId,
    required int createdAt,
    String? senderImageUrl,
    required bool fromDoctor,
    required bool messageRead,
    required Message chatMessage,
    required String receiverImageUrl,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);
}

@freezed
class ChatInfo with _$ChatInfo {
  const factory ChatInfo({
    required String chatId,
    required String sendToFcmToken,
    @Default('') String currentFcmToken,
    required String patientId,
    required String doctorId,
    String? senderImageUrl,
    required String senderName,
    required String receiverName,
    required String receiverImageUrl,
  }) = _ChatInfo;
  factory ChatInfo.fromJson(Map<String, Object?> json) =>
      _$ChatInfoFromJson(json);
}

@freezed
class LastMessage with _$LastMessage {
  const factory LastMessage({
    required String lastMessage,
    required int numberOfUnreadMessages,
    required bool fromDoctor,
  }) = _LastMessage;
  factory LastMessage.fromJson(Map<String, Object?> json) =>
      _$LastMessageFromJson(json);
}
