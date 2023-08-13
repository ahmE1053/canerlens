import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

class MyOfflineImageMessage extends StatelessWidget {
  const MyOfflineImageMessage(
      {Key? key, required this.imageMessage, this.savedOnline = false})
      : super(key: key);
  final ImageMessage imageMessage;
  final bool savedOnline;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ImageViewer(
                imageMessage: imageMessage,
                savedOnline: savedOnline,
              );
            },
          ),
        );
      },
      child: Hero(
        tag: imageMessage.id,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Image.file(
              File(
                savedOnline
                    ? imageMessage.metadata!['offlinePath']
                    : imageMessage.uri,
              ),
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 10,
              top: 10,
              height: 40,
              width: 40,
              child: Builder(
                builder: (context) {
                  final progress = imageMessage.metadata!['progress'] as num;
                  if (progress != 1) {
                    return CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          value: progress.toDouble(),
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageMessage,
    required this.savedOnline,
  });

  final ImageMessage imageMessage;
  final bool savedOnline;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageMessage.id,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                    Expanded(
                      child: FittedBox(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          '${LocaleKeys.sentAt.tr()} ${DateFormat.yMd(
                            context.locale.languageCode,
                          ).add_jm().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  imageMessage.createdAt!,
                                ),
                              )} ${LocaleKeys.by.tr()} ${imageMessage.author.firstName}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PhotoView(
                imageProvider: FileImage(File(
                  savedOnline
                      ? imageMessage.metadata!['offlinePath']
                      : imageMessage.uri,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
