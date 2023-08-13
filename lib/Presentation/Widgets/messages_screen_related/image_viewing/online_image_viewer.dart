import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:medapp4/generated/locale_keys.g.dart';

class MyOnlineImageMessage extends StatelessWidget {
  const MyOnlineImageMessage({
    Key? key,
    required this.imageMessage,
  }) : super(key: key);
  final ImageMessage imageMessage;
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
              );
            },
          ),
        );
      },
      child: Hero(
        tag: imageMessage.id,
        child: CachedNetworkImage(
          imageUrl: imageMessage.uri,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageMessage,
  });

  final ImageMessage imageMessage;

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
                imageProvider: CachedNetworkImageProvider(
                  imageMessage.uri,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
