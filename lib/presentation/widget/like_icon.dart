import 'package:flutter/material.dart';
import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';
import 'package:flutter_hive_state_master/services/like_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikeIcon extends StatelessWidget {
  const LikeIcon({
    Key? key,
    required this.likedList,
    required this.feedModel,
  }) : super(key: key);

  final Box likedList;
  final FeedModel? feedModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: likedList.listenable(),
      builder: (context, dynamic value, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(0),
          constraints: const BoxConstraints(),
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: likedList.keys.contains(feedModel!.id)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
            onTap: () {
              LikeService().handleLikeIconPressed(feedModel!, context);
            },
          ),
        );
      },
    );
  }
}
