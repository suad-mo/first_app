import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/list_media_new.dart';
import '../../models/enums/enums.dart';
import '../../models/item_media.dart';

class ScrollMedia extends StatefulWidget {
  const ScrollMedia(this.typeListMedia, {Key? key}) : super(key: key);

  final String typeListMedia;

  @override
  State<ScrollMedia> createState() => _ScrollMediaState();
}

class _ScrollMediaState extends State<ScrollMedia> {
  late ListMediaNew _list;
  List<ItemMedia> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    _list = ListMediaNew(mediaType: widget.typeListMedia);
    _items = _list.items;
    super.initState();
  }

  Future<List<ItemMedia>> _future() async {
    final x = await _list.fetchMediaItems();
    setState(() {
      _items = x;
    });
    return x;
  }

  Future<void> _updateItems() async {
    final x = await _list.fetchMediaItems();
    setState(() {
      _items = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final items = ListMediaProvider().mediaController(context, typeMedia);
    return FutureBuilder<List<ItemMedia>>(
      future: _future(),
      //initialData: [],
      builder: (context, snapshot) => !snapshot.hasData
          ? const CircularProgressIndicator()
          : Column(
              children: [
                AppBar(
                  title: Text(widget.typeListMedia),
                  backgroundColor: Theme.of(context).primaryColor,
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      onPressed: (() {}),
                      icon: const Icon(Icons.forward),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: RefreshIndicator(
                    edgeOffset: 20,
                    color: Colors.yellow,
                    onRefresh: _updateItems,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: 100,
                        color: Colors.green,
                        child: Image(
                          image: NetworkImage(snapshot.data![index].posterPath),
                          fit: BoxFit.cover,
                        ),
                        // child: Text(popularMovie[index].title),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
