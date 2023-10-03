import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_state_master/business_logic/feed/feed_cubit.dart';
import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';
import 'package:flutter_hive_state_master/presentation/widget/liked_tile.dart';
import 'package:flutter_hive_state_master/presentation/widget/loading_card.dart';
import 'package:flutter_hive_state_master/util/utils/constants.dart';

class FeedListScreen extends StatelessWidget {
  const FeedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late List<FeedModel> feedList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade200,
        centerTitle: false,
        title: const Text(
          'Feed List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        elevation: 0.5,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                FEED_LIKED_LIST_SCREEN,
              );
            },
            icon: const Icon(Icons.favorite),
            color: Colors.pink,
          )
        ],
      ),
      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return showLoaderView();
          } else if (state is FeedListLoaded) {
            feedList = state.feedList;
          }
          return showFeedListView(context, feedList);
        },
      ),
    );
  }

  Widget showFeedListView(BuildContext context, List<FeedModel> feedList) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      shrinkWrap: true,
      itemCount: feedList.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemBuilder: (BuildContext context, int index) {
        return feedList[index].urlToImage != null
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, FEED_DETAIL_SCREEN,
                      arguments: feedList[index]);
                },
                child: LikedTile(
                  feedModel: feedList[index],
                ),
              )
            : Container();
      },
    );
  }

  Widget showLoaderView() {
    List<Widget> loaderView = [];
    List.generate(5, (index) {
      return loaderView.add(
        const Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: LoadingCard(height: 280),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
    });
    return SingleChildScrollView(
      child: Column(
        children: loaderView,
      ),
    );
  }
}
