import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/data source/appointments_remote_data_source.dart';
import '../../data/data source/doctor_remote_data_source.dart';
import '../../data/data source/patient_remote_date_source.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/doctor.dart';
import '../utilities/appointment_error_state.dart';
import '../utilities/show_snack_bar.dart';

class BookAppointmentNotifier extends Notifier<Appointment> {
  @override
  Appointment build() {
    return const Appointment(
      id: 'id',
      day: '',
      time: '',
      forAnotherPatient: false,
      didLeaveCancellationReason: false,
      didLeaveReview: false,
      phoneNumber: '',
      appointmentState: AppointmentState.coming,
      appointmentLocation: AppointmentLocation.atClinic,
      additionalInfo: '',
      doctorId: '',
      timeLeft: Duration(),
    );
  }

  void copyWith(Appointment appointment) {
    state = appointment;
  }

  void reset() {
    ref.invalidateSelf();
    ref.read(selectedOnlineDayTimes.notifier).update((state) => []);
    ref.read(selectedOfflineDayTimes.notifier).update((state) => null);
  }

  void changeDay(String day) {
    state = state.copyWith(day: day);
  }

  void changeTime(String time) {
    state = state.copyWith(time: time);
  }

  void changeDoctor(String id) {
    state = state.copyWith(doctorId: id);
  }

  Future<bool> registerAppointment(
    BuildContext context,
    ValueNotifier<AppointmentErrorState> errorState,
    String phoneNumber,
    String additionalInfo,
    String doctorId,
  ) async {
    //To not trigger the timer again in case he pressed the button again before the 3 second timer.
    if (errorState.value.day || errorState.value.time) return false;
    //if the user didn't select a day, trigger an error state that changes all the days borders to red
    //and shows a snack bar
    if (state.day == '') {
      errorState.value = const AppointmentErrorState(day: true);
      showSnackBar(context, 'Please select a day');
      Future.delayed(const Duration(seconds: 3)).then(
        (value) {
          errorState.value = const AppointmentErrorState();
        },
      );
      return false;
    }

    //if the user didn't select a time, trigger an error state that changes all the times borders to red
    //and shows a snack bar.
    if (state.time == '') {
      errorState.value = const AppointmentErrorState(time: true);
      showSnackBar(context, 'Please select a time');
      Future.delayed(const Duration(seconds: 3)).then(
        (value) {
          errorState.value = const AppointmentErrorState();
        },
      );
      return false;
    }

    //generate an id for the appointment
    final id = const Uuid().v4();

    state = state.copyWith(
      additionalInfo: additionalInfo,
      phoneNumber: phoneNumber,
      doctorId: doctorId,
      id: id,
      timeLeft: DateTime.parse('${state.day} ${state.time}').difference(
        DateTime.now(),
      ),
    );

    await FirebaseFirestore.instance.collection('appointments').doc(id).set(
          state.toJson(),
        );
    final doctor =
        ref.read(doctorsNotifierProvider.notifier).getDoctorById(doctorId);
    final patientRef = ref.read(patientRemoteDataSourceProvider).value!;
    final appointments = List<String>.from(patientRef.appointments)..add(id);

    if (state.appointmentLocation == AppointmentLocation.online) {
      final chatId = const Uuid().v4();

      final doctorChatList = List<ChatInfo>.from(doctor.chatList)
        ..add(
          ChatInfo(
            senderImageUrl: doctor.imageUrl,
            currentFcmToken: doctor.fcmToken,
            sendToFcmToken: patientRef.fcmToken,
            chatId: chatId,
            patientId: patientRef.id,
            doctorId: doctorId,
            senderName: doctor.name,
            receiverName: patientRef.name,
            receiverImageUrl: patientRef.imageUrl,
          ),
        );
      final patientChatList = List<ChatInfo>.from(patientRef.chatList)
        ..add(
          ChatInfo(
            senderImageUrl: patientRef.imageUrl,
            currentFcmToken: patientRef.fcmToken,
            sendToFcmToken: doctor.fcmToken,
            chatId: chatId,
            patientId: patientRef.id,
            doctorId: doctorId,
            senderName: patientRef.name,
            receiverName: doctor.name,
            receiverImageUrl: doctor.imageUrl,
          ),
        );
      ref.read(patientRemoteDataSourceProvider.notifier).copyWith(
            patientRef.copyWith(
              chatList: patientChatList,
              appointments: appointments,
            ),
          );

      await FirebaseFirestore.instance
          .collection('patients')
          .doc(patientRef.id)
          .update(
        {
          'appointments': appointments,
          'chatList': patientChatList.map((e) => e.toJson()).toList(),
        },
      );

      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctor.id)
          .update(
        {
          'chatList': doctorChatList.map((e) => e.toJson()).toList(),
        },
      );

      ref.invalidate(appointmentNotifierProvider);
      return true;
    }
    ref.read(patientRemoteDataSourceProvider.notifier).copyWith(
          patientRef.copyWith(appointments: appointments),
        );
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(patientRef.id)
        .update(
      {
        'appointments': appointments,
      },
    );

    ref.invalidate(appointmentNotifierProvider);
    return true;
  }

  Future<bool> changeAlreadyBookedOnlineTime(
    BuildContext context,
    ValueNotifier<AppointmentErrorState> errorState,
    String appointmentId,
  ) async {
    if (errorState.value.day || errorState.value.time) return false;

    if (state.day == '') {
      errorState.value = const AppointmentErrorState(day: true);
      showSnackBar(context, 'Please select a day');
      Future.delayed(const Duration(seconds: 3)).then(
        (value) {
          errorState.value = const AppointmentErrorState();
        },
      );
      return false;
    }

    //if the user didn't select a time, trigger an error state that changes all the times borders to red
    //and shows a snack bar.
    if (state.time == '') {
      errorState.value = const AppointmentErrorState(time: true);
      showSnackBar(context, 'Please select a time');
      Future.delayed(const Duration(seconds: 3)).then(
        (value) {
          errorState.value = const AppointmentErrorState();
        },
      );
      return false;
    }
    final duration = DateTime.parse('${state.day} ${state.time}')
        .add(const Duration(days: 35, hours: 5))
        .difference(
          DateTime.now(),
        );
    await ref.read(appointmentNotifierProvider.notifier).changeTime(
          appointmentId,
          state.day,
          duration,
          state.time,
        );

    return true;
  }

  Future<bool> changeAlreadyBookedOfflineTime(
    BuildContext context,
    ValueNotifier<AppointmentErrorState> errorState,
    String appointmentId,
  ) async {
    if (errorState.value.day) return false;
    if (state.day == '') {
      errorState.value = const AppointmentErrorState(day: true);
      showSnackBar(context, 'Please select a day');
      Future.delayed(const Duration(seconds: 3)).then(
        (value) {
          errorState.value = const AppointmentErrorState();
        },
      );
      return false;
    }
    final duration = DateTime.parse(state.day)
        .add(const Duration(days: 35, hours: 5))
        .difference(
          DateTime.now(),
        );

    await ref.read(appointmentNotifierProvider.notifier).changeTime(
          appointmentId,
          state.day,
          duration,
          state.time,
        );

    return true;
  }
}

final bookAppointmentProvider =
    NotifierProvider<BookAppointmentNotifier, Appointment>(
  () => BookAppointmentNotifier(),
);

final selectedOnlineDayTimes = StateProvider<List<TimeInDayOnline>>(
  (ref) => [],
);

final selectedOfflineDayTimes =
    StateProvider<OfflineAvailability?>((ref) => null);
