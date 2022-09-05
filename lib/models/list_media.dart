import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../configuration.dart';
import '../models/item_media.dart';

class ListMedia with ChangeNotifier {
  ListMedia({required this.mediaType}) {
    _initMediaItems();
  }

  int _page = 1;
  int get page => _page;
  // final String mediaType;
  final String mediaType;

  final List<ItemMedia> _items = [];
  List<ItemMedia> get items => [..._items];

  void update(String typeMedia) {
    // mediaType = typeMedia;
    _initMediaItems();
  }

  Future<void> _initMediaItems() async {
    final url = Uri.https(
      TMDB.apiBaseUrl3,
      '/3/$mediaType',
      {'page': page.toString()},
    );
    try {
      final res = await http.get(url, headers: {
        'Authorization': 'Bearer ${TMDB.apiReadAccessToken}',
        'Content-Type': 'application/json;charset=utf-8'
      });
      if (res.body.isEmpty) return;
      final extractedData = jsonDecode(res.body);
      _fromJson(extractedData);
      notifyListeners();
    } catch (e) {
      print('List_media initilization...');
      print(e.toString());
      rethrow;
    }
  }

  void _initialization() async {
    _page += 1;
    final url = Uri.https(
      TMDB.apiBaseUrl3,
      '/3/$mediaType',
      {'page': _page.toString()},
    );
    try {
      final res = await http.get(url, headers: {
        'Authorization': 'Bearer ${TMDB.apiReadAccessToken}',
        'Content-Type': 'application/json;charset=utf-8'
      });
      if (res.body.isEmpty) return;
      final extractedData = jsonDecode(res.body);
      _fromJson(extractedData);
    } catch (e) {
      print('List_media initilization...');
      print(e.toString());
      rethrow;
    }
  }

  void nextPage() {
    _initialization();
  }

  void _fromJson(Map<String, dynamic> data) {
    try {
      if (data['results'] != null) {
        final items = <ItemMedia>[];
        data['results'].forEach((v) {
          final itemMedia = ItemMedia.fromJson(v);
          if (itemMedia.isOK) {
            items.add(ItemMedia.fromJson(v));
          }
        });
        _items.addAll(items);
        notifyListeners();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Class ListMedia.fromJson...');
      print(e.toString());
    }
  }
}
