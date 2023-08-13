import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'request_agora_token.dart';
import '../providers/call_mic_speaker_providers.dart';

class AgoraEngine extends Notifier<RtcEngine> {
  @override
  RtcEngine build() {
    return createAgoraRtcEngine();
  }

  bool _joined = false;
  bool _muted = false;
  bool _speaker = false;
  bool get isJoined => _joined;

  Future<void> initializeEngine() async {
    _joined = true;
    await state.initialize(
      const RtcEngineContext(
        appId: 'b35c4ef7d00c41f5a3b99728cb6a1430',
        logConfig: LogConfig(
          level: LogLevel.logLevelNone,
        ),
      ),
    );
    state.setDefaultAudioRouteToSpeakerphone(false);
  }

  Future<void> join(String token, String channelName, int uid) async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    final to = await requestAgoraToken(channelName, uid);
    _joined = true;
    await state.joinChannel(
      token: to,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  Future<void> mute() async {
    if (_muted) {
      _muted = false;
      ref.read(mutedProvider.notifier).update((state) => false);
      await state.muteLocalAudioStream(false);
      return;
    }
    _muted = true;
    ref.read(mutedProvider.notifier).update((state) => true);
    state.muteLocalAudioStream(true);
  }

  Future<void> speaker() async {
    if (_speaker) {
      _speaker = false;
      ref.read(speakerProvider.notifier).update((state) => false);

      await state.setEnableSpeakerphone(false);
      return;
    }
    _speaker = true;
    ref.read(speakerProvider.notifier).update((state) => true);
    state.setEnableSpeakerphone(true);
  }

  Future<void> leave() async {
    _joined = false;
    _muted = false;
    _speaker = false;
    await state.leaveChannel();
    await state.release();
    ref.read(mutedProvider.notifier).update((state) => false);
    ref.read(speakerProvider.notifier).update((state) => false);
    ref.invalidateSelf();
  }
}

final agoraEngineProvider =
    NotifierProvider<AgoraEngine, RtcEngine>(() => AgoraEngine());
