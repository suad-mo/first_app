// import 'dart:async';
import 'package:async/async.dart';
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
  // Future<List<ItemMedia>> Function() f = () async {
  //   if (_list != null) {

  //   }
  //   return _list.fetchMediaItems();
  // };
  bool _isLoading = false;
  late CancelableOperation<List<ItemMedia>> _myCancelableFuture;
  late CancelableOperation<void> _updateCancelableFuture;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _list = ListMediaNew(mediaType: widget.typeListMedia);
      _myCancelableFuture = CancelableOperation.fromFuture(_future());
      _updateCancelableFuture = CancelableOperation.fromFuture(_updateItems());
      //_myCancelableFuture = CancelableOperation.fromFuture(_future());
    });
    // _items = _list.items;
    super.initState();
  }

  Future<List<ItemMedia>> _future() async {
    final x = _list;
    final f = await x.fetchMediaItems();
    // setState(() {
    //   _list = x;
    // });

    return f;
    // final x = await _list.fetchMediaItems();
    // setState(() {
    //   _items = x;
    // });
    // return x;
  }

  // final CancelableOperation<List<ItemMedia>> _myCancelableFuture =
  //     CancelableOperation.fromFuture(_future(), onCancel: (() {}));

  Future<void> _updateItems() async {
    // final x = await _list.fetchMediaItems();
    // setState(() {
    //   _items = x;
    // });
    await _list.fetchMediaItems();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _myCancelableFuture.cancel();
    _updateCancelableFuture.cancel();
    // CancelableCompleter(onCancel: _future).complete(); // : _future = onCancel;
    // CancelableCompleter(onCancel: _updateItems).complete();
    // // setState(() {});
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
