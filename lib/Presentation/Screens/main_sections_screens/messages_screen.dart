import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

import '../../../core/providers/language_provider.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../../domain/entities/chat.dart';
import '../../widgets/home_screen_related/not_found.dart';
import '../../widgets/messages_screen_related/chat_card.dart';
import '../../../core/utilities/widget_helper.dart';

@RoutePage()
class MessagesScreen extends HookConsumerWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final lastMessageRef = FirebaseFirestore.instance
        .collection('lastMessages')
        .withConverter<LastMessage>(
          fromFirestore: (snapshot, _) =>
              LastMessage.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
    final lastMessages = useStream(
      useMemoized(
        () => lastMessageRef.snapshots(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.messagesNavBar.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) {
            final patient = ref.watch(patientRemoteDataSourceProvider).value!;
            if (patient.chatList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NotFound(
                    text: LocaleKeys.noChats.tr(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AutoTabsRouter.of(context).setActiveIndex(0);
                    },
                    child: Text(
                      LocaleKeys.goHome.tr(),
                    ),
                  ),
                ],
              );
            }
            return Builder(
              builder: (context) {
                return ListView.separated(
                  itemCount: patient.chatList.length,
                  itemBuilder: (context, index) {
                    final chat = patient.chatList[index];
                    final lastMessage = lastMessages.data?.docs
                        .where((element) => element.id == chat.chatId)
                        .firstOrNull;
                    return ChatCard(
                      chatInfo: chat,
                      lastMessage: lastMessage?.data(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Divider(
                        height: 1,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        thickness: 1,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ).getDoctorAndPatientInfo(ref);
  }
}
