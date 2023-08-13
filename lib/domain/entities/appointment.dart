import 'package:freezed_annotation/freezed_annotation.dart';

import 'doctor.dart';
part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  @JsonSerializable(explicitToJson: true)
  const factory Appointment({
    required String id,
    required String day,
    required String time,
    required bool forAnotherPatient,
    required bool didLeaveReview,
    required bool didLeaveCancellationReason,
    required String phoneNumber,
    required AppointmentState appointmentState,
    required AppointmentLocation appointmentLocation,
    required String additionalInfo,
    required String doctorId,
    required Duration timeLeft,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, Object?> json) =>
      _$AppointmentFromJson(json);
}

enum AppointmentState {
  coming,
  done,
  absent,
}

enum AppointmentLocation {
  online,
  atClinic,
}

class OnlineDayInfoForAppointmentBooking {
  final TimeStates timeState;
  final OnlineAvailability? onlineAvailability;
  const OnlineDayInfoForAppointmentBooking(
      {required this.timeState, this.onlineAvailability});
}

class OfflineDayInfoForAppointmentBooking {
  final TimeStates timeState;
  final OfflineAvailability? offlineAvailability;
  const OfflineDayInfoForAppointmentBooking(
      {required this.timeState, this.offlineAvailability});
}

enum TimeStates {
  selected,
  available,
  disabled,
  error,
}
