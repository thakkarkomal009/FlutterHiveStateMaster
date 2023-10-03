import 'package:flutter/material.dart';
import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';
import 'package:flutter_hive_state_master/presentation/widget/liked_tile.dart';
import 'package:flutter_hive_state_master/util/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FeedLikedList extends StatelessWidget {
  FeedLikedList({Key? key}) : super(key: key);

  final likedList = Hive.box(likeDB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade200,
        title: const Text(
          'Feed Liked List',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 18),
        ),
        elevation: 0.5,
        leading: IconButton(
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: likedList.listenable(),
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    if (likedList.isEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Your Liked Feed is feeling a bit lonely. Start liking posts to fill it with your favorite content!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: likedList.length,
                      padding: const EdgeInsets.all(15),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        FeedModel feedModel = FeedModel(
                          id: likedList.getAt(index)['id'],
                          title: likedList.getAt(index)['title'],
                          description: likedList.getAt(index)['description'],
                          name: likedList.getAt(index)['name'],
                          urlToImage: likedList.getAt(index)['urlToImage'],
                          author: likedList.getAt(index)['author'],
                        );
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, FEED_DETAIL_SCREEN,
                                arguments: feedModel);
                          },
                          child: LikedTile(
                            feedModel: feedModel,
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
