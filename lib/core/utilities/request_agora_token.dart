import 'package:dio/dio.dart';

Future<String> requestAgoraToken(String channelName, int uid) async {
  final url =
      'https://agora-token-service-production-5a2d.up.railway.app/rtc/$channelName/1/uid/$uid';
  final response = await Dio().get(
    url,
  );
  return response.data['rtcToken'];
}
