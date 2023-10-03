//navigate to particular screen
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_state_master/business_logic/feed/feed_cubit.dart';
import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';
import 'package:flutter_hive_state_master/presentation/screens/feed_detail.dart';
import 'package:flutter_hive_state_master/presentation/screens/feed_liked_list.dart';
import 'package:flutter_hive_state_master/presentation/screens/feed_list_screen.dart';
import 'package:flutter_hive_state_master/util/utils/constants.dart';

class AppRouter {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case FEED_LIST_SCREEN:
        final feedCubit = FeedCubit();
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: feedCubit,
              child: const FeedListScreen(),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return getTransition(animation, child);
          },
          fullscreenDialog: true,
        );
      case FEED_LIKED_LIST_SCREEN:
        final feedCubit = FeedCubit();
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: feedCubit,
              child: FeedLikedList(),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return getTransition(animation, child);
          },
          fullscreenDialog: true,
        );
      case FEED_DETAIL_SCREEN:
        final feedCubit = FeedCubit();
        final feedModel = routeSettings.arguments as FeedModel?;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: feedCubit,
              child: FeedLikedDetail(feedModel: feedModel),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return getTransition(animation, child);
          },
          fullscreenDialog: true,
        );
      default:
        final feedCubit = FeedCubit();
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider.value(
              value: feedCubit,
              child: const FeedListScreen(),
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return getTransition(animation, child);
          },
          fullscreenDialog: true,
        );
    }
  }
}

FadeTransition getTransition(Animation<double> animation, Widget child) {
  animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);

  return FadeTransition(opacity: animation, child: child);
}
