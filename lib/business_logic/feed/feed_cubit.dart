import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_state_master/business_logic/feed/model/feed_model.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial()) {
    getFeedList();
  }

  void getFeedList() async {
    emit(FeedLoading());
    String data = await rootBundle.loadString('assets/feed_list.json');

    List? decodedData = jsonDecode(data);

    List<FeedModel> feedList =
        decodedData!.map((m) => FeedModel.fromJson(m)).toList();

    emit(FeedListLoaded(feedList));
  }
}
