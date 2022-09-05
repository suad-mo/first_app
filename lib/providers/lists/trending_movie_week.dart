import 'package:flutter/material.dart';

import '../../models/item_media.dart';
import '../../models/list_media.dart';
import '../../models/enums/enums.dart';

class TrendingMovieWeek with ChangeNotifier {
  TrendingMovieWeek() {
    _listMedia = ListMedia(mediaType: ListMediaType.trendingMovieWeek);
    notifyListeners();
  }

  static const listMediaType = ListMediaType.trendingMovieWeek;
  late ListMedia _listMedia;
  ListMedia get listMedia => _listMedia;
  List<ItemMedia> get items => _listMedia.items;

  Future<void> nextPagePopularMovie() async {
    //trendingMoviesWeek.nextPage();
    notifyListeners();
  }
}
