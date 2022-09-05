import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../configuration.dart';
import '../../models/movies/res_movies.dart';

class TypeMovies with ChangeNotifier {
  String? typeMovie;
  int page = 1;
  List<int> pages = [1];
  Map<int, List<Results>> mapMovies = {};
  int? totalPages;
  int? totalResults;
  int countMovies = 0;

  void update(String type) {
    typeMovie = type;
    inititial();
  }

  inititial() async {
    final url = Uri.https(
      TMDB.apiBaseUrl3,
      '/3/$typeMovie',
      {'page': page.toString()},
    );
    print('Initial: $url');
    try {
      final res = await http.get(url, headers: {
        'Authorization': 'Bearer ${TMDB.apiReadAccessToken}',
        'Content-Type': 'application/json;charset=utf-8'
      });
      if (res.body.isEmpty) return;
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      final ResMovies resMovies = ResMovies.fromJson(extractedData);
      final results = resMovies.results;

      if (results == null) return;
      final intListResMovies = <int, List<Results>>{page: results};
      mapMovies.addAll(intListResMovies);
      countMovies += results.length;
      totalPages = resMovies.totalPages;
      totalResults = resMovies.totalResults;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void addNextPage() async {
    page++;
    final url = Uri.https(
      TMDB.apiBaseUrl3,
      typeMovie!,
      {'page': page},
    );
    try {
      final res = await http.get(url, headers: {
        'Authorization': 'Bearer ${TMDB.apiReadAccessToken}',
        'Content-Type': 'application/json;charset=utf-8'
      });
      if (res.body.isEmpty) return;
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      final ResMovies resMovies = ResMovies.fromJson(extractedData);
      final results = resMovies.results;
      if (results == null || results.isEmpty) return;
      final intListResMovies = <int, List<Results>>{page: results};
      mapMovies.addAll(intListResMovies);
      countMovies += results.length;
      pages.add(page);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  List<Results> listMovies() {
    List<Results> list = [];
    mapMovies.forEach((_, value) {
      list.addAll(value);
    });
    return list;
  }
}
