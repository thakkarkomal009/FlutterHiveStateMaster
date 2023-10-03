part of 'feed_cubit.dart';

abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedListLoaded extends FeedState {
  final List<FeedModel> feedList;

  FeedListLoaded(this.feedList);
}
