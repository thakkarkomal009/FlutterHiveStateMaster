import 'package:flutter/material.dart';
import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';
import 'package:flutter_hive_state_master/presentation/widget/like_icon.dart';
import 'package:flutter_hive_state_master/util/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FeedLikedDetail extends StatelessWidget {
  final FeedModel? feedModel;

  FeedLikedDetail({Key? key, this.feedModel}) : super(key: key);

  final likedList = Hive.box(likeDB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade200,
        title: Text(
          feedModel!.title!,
          style: const TextStyle(
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LikeIcon(
              likedList: likedList,
              feedModel: feedModel,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: ValueListenableBuilder(
              valueListenable: likedList.listenable(),
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 250,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        child: Image.network(
                          feedModel!.urlToImage!,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          color: Colors.cyan.shade50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                feedModel!.author!,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                feedModel!.publishedAt!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            feedModel!.description!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            feedModel!.content!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
