import 'package:freezed_annotation/freezed_annotation.dart';
part 'call_state.freezed.dart';
part 'call_state.g.dart';

@freezed
class CallState with _$CallState {
  const factory CallState({
    @Default('') String token,
    required String doctorId,
    required String channelName,
    required String patientId,
    @Default(CallStates.nothing) CallStates callStates,
  }) = _CallState;
  factory CallState.fromJson(Map<String, Object?> json) =>
      _$CallStateFromJson(json);
  factory CallState.nullState() =>
      const CallState(doctorId: '', patientId: '', channelName: '');
}

enum CallStates {
  incomingCall,
  ongoingCall,
  nothing,
  calling,
}
