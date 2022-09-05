import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_app/models/list_media.dart';
import 'package:first_app/models/enums/enums.dart';
import '../models/item_media.dart';

class MediasProvider with ChangeNotifier {
  MediasProvider() {
    _trendingMoviesWeek = ListMedia(mediaType: ListMediaType.trendingMovieWeek);
    _popularMovie = ListMedia(mediaType: 'movie/popular');
    _upcomingMovie = ListMedia(mediaType: 'movie/upcoming');

    notifyListeners();
  }

  late ListMedia _trendingMoviesWeek;

  ListMedia get trendingMoviesWeek => _trendingMoviesWeek;
  List<ItemMedia> get itemsTrendingMoviesWeek => _trendingMoviesWeek.items;

  late ListMedia _popularMovie;
  ListMedia get popularMovie => _popularMovie;
  List<ItemMedia> get itemsPopularMovie => popularMovie.items;

  late ListMedia _upcomingMovie;
  ListMedia get upcomingMovie => _upcomingMovie;
  List<ItemMedia> get itemsUpcomingMovie => upcomingMovie.items;

  void nextPageTrendingVeekMovie() {
    //trendingMoviesWeek.nextPage();
    notifyListeners();
  }

  Future<void> nextPagePopularMovie() async {
    //trendingMoviesWeek.nextPage();
    notifyListeners();
  }
}
