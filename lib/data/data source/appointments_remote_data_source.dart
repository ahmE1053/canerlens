import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/appointment.dart';
import 'patient_remote_date_source.dart';

class AppointmentRemoteDataSourceNotifier
    extends AsyncNotifier<List<Appointment>> {
  List<Appointment> _allAppointmentsList = [];
  @override
  Future<List<Appointment>> build() async {
    final appointmentIdList =
        ref.watch(patientRemoteDataSourceProvider).value!.appointments;
    final List<Appointment> appointmentList = [];

    //this is used for the online and offline filter

    for (var id in appointmentIdList) {
      final appointmentMap = ((await FirebaseFirestore.instance
              .collection('appointments')
              .doc(id)
              .get())
          .data()!);
      final appointment = Appointment.fromJson(appointmentMap);
      appointmentList.add(appointment);
    }
    _allAppointmentsList = List.from(appointmentList);
    return appointmentList;
  }

  void filterOffline() {
    final list = <Appointment>[];
    for (int i = 0; i < _allAppointmentsList.length; i++) {
      if (!(_allAppointmentsList[i].appointmentLocation ==
          AppointmentLocation.atClinic)) {
        list.add(_allAppointmentsList[i]);
      }
    }
    state = AsyncData(list);
  }

  void filterOnline() {
    final list = <Appointment>[];
    for (int i = 0; i < _allAppointmentsList.length; i++) {
      if (!(_allAppointmentsList[i].appointmentLocation ==
          AppointmentLocation.online)) {
        list.add(_allAppointmentsList[i]);
      }
    }
    state = AsyncData(list);
  }

  void returnToNormal() {
    state = AsyncData(_allAppointmentsList);
  }

  Future<void> cancelAppointment(String id) async {
    final appointment =
        state.value!.firstWhere((element) => element.id == id).copyWith(
              appointmentState: AppointmentState.absent,
            );
    await FirebaseFirestore.instance.collection('appointments').doc(id).set(
          appointment.toJson(),
        );
    List<Appointment> appointments = [];
    for (Appointment i in state.value!) {
      if (i.id == id) {
        appointments.add(appointment);
        continue;
      }
      appointments.add(i);
    }
    state = AsyncValue.data(appointments);
  }

  Future<void> changeTime(String id, String day, Duration duration,
      [String? time]) async {
    var appointment = state.value!.firstWhere((element) => element.id == id);
    appointment = appointment.copyWith(
      day: day,
      time: time ?? appointment.time,
      timeLeft: duration,
    );
    await FirebaseFirestore.instance.collection('appointments').doc(id).set(
          appointment.toJson(),
        );
    List<Appointment> appointments = [];
    for (Appointment i in state.value!) {
      if (i.id == id) {
        appointments.add(appointment);
        continue;
      }
      appointments.add(i);
    }
    state = AsyncValue.data(appointments);
  }

  Future<void> changeReviewOrCancellationReasonState(String id,
      {bool? didLeaveReview, bool? didLeaveCancellationReason}) async {
    var appointment = state.value!.firstWhere((element) => element.id == id);
    appointment = appointment.copyWith(
      didLeaveReview: didLeaveReview ?? appointment.didLeaveReview,
      didLeaveCancellationReason:
          didLeaveCancellationReason ?? appointment.didLeaveCancellationReason,
    );
    await FirebaseFirestore.instance.collection('appointments').doc(id).set(
          appointment.toJson(),
        );
    List<Appointment> appointments = [];
    for (Appointment i in state.value!) {
      if (i.id == id) {
        appointments.add(appointment);
        continue;
      }
      appointments.add(i);
    }
    state = AsyncValue.data(appointments);
  }
}

final appointmentNotifierProvider = AsyncNotifierProvider<
    AppointmentRemoteDataSourceNotifier, List<Appointment>>(
  () => AppointmentRemoteDataSourceNotifier(),
);
