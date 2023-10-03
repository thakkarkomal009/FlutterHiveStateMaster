import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';
import 'package:flutter_hive_state_master/presentation/widget/like_icon.dart';
import 'package:flutter_hive_state_master/util/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikedTile extends StatelessWidget {
  final FeedModel? feedModel;

  const LikedTile({this.feedModel, super.key});

  @override
  Widget build(BuildContext context) {
    final likedList = Hive.box(likeDB);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8)),
          child: SizedBox(
            height: 250,
            child: Image.network(
              feedModel!.urlToImage!,
              fit: BoxFit.fill,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                child: Container(
                  height: MediaQuery.of(context).size.height / 7.5,
                  color: Colors.black54.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                feedModel!.title!,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                feedModel!.author!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        LikeIcon(
                          likedList: likedList,
                          feedModel: feedModel,
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
