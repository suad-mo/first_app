import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_app/models/item_media.dart';
import '../../providers/lists/trending_movie_week.dart';

class ListMediaType {
  static const trendingMovieWeek = 'trending/movie/week';
  static const trendingMovieDay = 'trending/movie/day';
  static const movieNowPlaying = '/movie/now_playing';
  static const movieLatest = 'movie/latest';
  static const movieUpcoming = 'movie/upcoming';
  static const moviePopular = 'movie/popular';
  static const movieTopRated = 'movie/top_rated';

  static const tvAiringToday = 'tv/airing_today';
  static const tvOnTheAir = 'tv/on_the_air';
  static const tvTopRated = 'tv/top_rated';
  static const tvLatest = 'tv/latest';
  static const tvPopular = 'tv/popular';
  static const trendingTvWeek = 'trending/tv/week';
  static const trendingTvDay = 'trending/tv/day';
}

class ListMediaProvider {
  List<ItemMedia> mediaController(BuildContext ctx, String listMediaType) {
    switch (listMediaType) {
      case ListMediaType.trendingMovieWeek:
        return Provider.of<TrendingMovieWeek>(ctx).items;
      default:
        return [];
    }
  }
}
