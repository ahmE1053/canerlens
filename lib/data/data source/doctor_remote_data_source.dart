import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/call_state.dart';
import '../../domain/entities/doctor.dart';

/*
* holds a list of doctors instances as a state
* uses a converter to change from json to doctor member
* and provides this state to the app
* */

class DoctorRemoteDataSource extends AsyncNotifier<List<Doctor>> {
  final firestoreReference = FirebaseFirestore.instance.collection('doctors');

  @override
  Future<List<Doctor>> build() async {
    final snapshot = await firestoreReference
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Doctor.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) => {},
        )
        .get();

    final doctorsList = snapshot.docs.map((e) => e.data()).toList();

    return doctorsList;
  }

  List<Doctor> getFavoriteDoctors(List<String> userFavoriteDoctors) {
    final list = <Doctor>[];
    for (String id in userFavoriteDoctors) {
      for (Doctor doctor in state.value!) {
        if (doctor.id == id) list.add(doctor);
      }
    }
    return list;
  }

  Doctor getDoctorById(String id) {
    return state.value!.firstWhere((element) => element.id == id);
  }

  Future<void> endCall(String id) async {
    final doctorRef = state.value!.firstWhere((element) => element.id == id);
    final doctor = Doctor.fromJson((await FirebaseFirestore.instance
            .collection('doctors')
            .doc(doctorRef.id)
            .get())
        .data()!);
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctor.id)
        .update(
          doctor
              .copyWith(
                callState: CallState.nullState(),
              )
              .toJson(),
        );
    ref.invalidateSelf();
  }

  Future<void> answerCall(String id) async {
    final doctorRef = state.value!.firstWhere((element) => element.id == id);
    final doctor = Doctor.fromJson(
      (await FirebaseFirestore.instance
              .collection('doctors')
              .doc(doctorRef.id)
              .get())
          .data()!,
    );

    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctor.id)
        .update(
          doctor
              .copyWith(
                callState: doctor.callState!.copyWith(
                  callStates: CallStates.ongoingCall,
                ),
              )
              .toJson(),
        );
    ref.invalidateSelf();
  }

  Future<void> startCall(
      String channelName, String patientId, String doctorId) async {
    final doctor = state.value!.firstWhere((element) => element.id == doctorId);
    final callState = CallState(
      patientId: patientId,
      doctorId: doctorId,
      channelName: channelName,
      callStates: CallStates.incomingCall,
    );
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctor.id)
        .update(
          doctor
              .copyWith(
                callState: callState,
              )
              .toJson(),
        );
    ref.invalidateSelf();
  }

  Future<void> leaveReview(Doctor doctor, Review review) async {
    final reviews = [...doctor.reviews, review];
    final doctorWithNewReview =
        state.value!.firstWhere((element) => element == doctor).copyWith(
              reviews: reviews,
            );
    double rating = 0.0;
    for (var i in reviews) {
      rating += i.rating;
    }
    rating = double.parse((rating / reviews.length).toStringAsFixed(2));
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctor.id)
        .update(
      {
        'rating': rating,
        'reviews': reviews.map((e) => e.toJson()),
      },
    );
    final doctors = <Doctor>[];
    for (Doctor i in state.value!) {
      if (i == doctor) {
        doctors.add(doctorWithNewReview);
        continue;
      }
      doctors.add(i);
    }
    state = AsyncData(doctors);
  }
}

final doctorsNotifierProvider =
    AsyncNotifierProvider<DoctorRemoteDataSource, List<Doctor>>(
  () => DoctorRemoteDataSource(),
);
