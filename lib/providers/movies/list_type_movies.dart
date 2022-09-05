import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/movies/res_movies.dart';
import '../../providers/movies/type_movies.dart';

enum TypeAction {
  nextTrendingDWeek,
  nextPopular,
}

class ListTypeMovies with ChangeNotifier {
  //ListTypeMovies(TypeAction typeMovie);
  ListTypeMovies() {
    print('Constructor ListTypeMovies Class!');

    // notifyListeners();
  }

  TypeMovies? _trendingWeekMovies;
  TypeMovies? _popularMovies;

  void nextTrendingWeemMovies() {
    _trendingWeekMovies!.addNextPage();
    notifyListeners();
  }

  void nextPopularMovies() {
    _trendingWeekMovies!.addNextPage();
    notifyListeners();
  }

  // List<Results>_listTrendingWeekMovies
  List<Results> get listTrendingWeekMovies {
    TypeMovies mov = TypeMovies()..update('trending/movie/week');
    return mov.listMovies();
  }

  List<Results> get listPopularMovies {
    TypeMovies mov = TypeMovies()..update('movie/popular');
    return mov.listMovies();
  }

  //List<Results> listPopularMovies() => popularMovies!.listMovies();
}
