// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../configuration.dart';
import '../models/item_media.dart';

class ListMediaNew with ChangeNotifier {
  ListMediaNew({required this.mediaType});

  final String mediaType;

  bool _isInit = true;
  bool get isInit => _isInit;
  int _page = 1;
  int get page => _page;

  final List<ItemMedia> _items = [];
  List<ItemMedia> get items => [..._items];

  Future<void> updateMediaItems() async {
    if (_isInit) {
      return;
    }
    fetchMediaItems();
  }

  void updateItems() {
    if (_isInit) {
      return;
    }
    fetchMediaItems();
  }

  Future<List<ItemMedia>> fetchMediaItems() async {
    if (_isInit) {
      _page = 1;
    } else {
      _page = _page + 1;
    }
    final url = Uri.https(
      TMDB.apiBaseUrl3,
      '/3/$mediaType',
      {'page': page.toString()},
    );
    try {
      return http.get(url, headers: {
        'Authorization': 'Bearer ${TMDB.apiReadAccessToken}',
        'Content-Type': 'application/json;charset=utf-8'
      }).then((res) {
        if (res.body.isEmpty) Exception('Greska...res.body.isEmpty = true');
        final extractedData = jsonDecode(res.body);
        return _getListfromJson(extractedData);
      });
    } catch (e) {
      _page = _page - 1;
      print('Class:List_media_new, fn:initMediaItems...');
      print(e.toString());
      rethrow;
    }
  }

  List<ItemMedia> _getListfromJson(Map<String, dynamic> data) {
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
        _isInit = false;
        notifyListeners();
      }
      return _items;
    } catch (e) {
      print('Class ListMedia.fromJson...');
      print(e.toString());
      rethrow;
    }
  }
}
