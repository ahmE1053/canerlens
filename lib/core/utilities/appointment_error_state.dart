class AppointmentErrorState {
  final bool day, time;
  const AppointmentErrorState({this.day = false, this.time = false});
  AppointmentErrorState copyWith({bool? day, bool? time}) {
    return AppointmentErrorState(
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }
}
