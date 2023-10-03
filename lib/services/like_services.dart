import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_state_master/util/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikeService {
  final likedList = Hive.box(likeDB);

  Future handleLikeIconPressed(FeedModel feedModel, context) async {
    if (likedList.keys.contains(feedModel.id)) {
      removeFromFeedLikeList(feedModel);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
              "Feed successfully removed from your favorites. Your preferences are now updated."),
        ),
      );
    } else {
      addToLikedFeedList(feedModel);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
              "Feed successfully added to your favorites! 🌟 Enjoy your curated content!"),
        ),
      );
    }
  }

  Future addToLikedFeedList(FeedModel feedModel) async {
    await likedList.put(feedModel.id, {
      'id': feedModel.id,
      'title': feedModel.title,
      'name': feedModel.name,
      'description': feedModel.description,
      'urlToImage': feedModel.urlToImage,
      'author': feedModel.author,
      'content': feedModel.content,
      'publishedAt': feedModel.publishedAt,
    });
  }

  Future removeFromFeedLikeList(FeedModel feedModel) async {
    await likedList.delete(feedModel.id);
  }

  Future clearLikedList() async {
    await likedList.clear();
  }
}
