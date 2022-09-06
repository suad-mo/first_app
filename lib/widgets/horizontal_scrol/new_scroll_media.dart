import 'package:async/async.dart';
import 'package:flutter/material.dart';
import '../../models/item_media.dart';
import '../../models/list_media_new.dart';

class NewScrollMedia extends StatefulWidget {
  const NewScrollMedia(this.listMedia, {Key? key}) : super(key: key);
  final ListMediaNew listMedia;

  @override
  State<NewScrollMedia> createState() => _NewScrollMediaState();
}

class _NewScrollMediaState extends State<NewScrollMedia> {
  ListMediaNew? _list;
  List<ItemMedia> _items = [];
  bool _isLoad = false;

  late CancelableOperation<List<ItemMedia>> _myCancelableFuture;
  late CancelableOperation<void> _updateCancelableFuture;

  @override
  void initState() {
    setState(() {
      _list = widget.listMedia;
      _items.addAll(widget.listMedia.items);
      _isLoad = true;
      // _myCancelableFuture = CancelableOperation.fromFuture(_future());
      _updateCancelableFuture = CancelableOperation.fromFuture(_updateItems());
    });
    // TODO: implement initState
    super.initState();
  }

  // Future<List<ItemMedia>> _future() async {
  //   final x = await _list.fetchMediaItems();
  //   // setState(() {});
  //   return x;
  // }

  Future<void> _updateItems() async {
    final a = _list;
    await a?.fetchMediaItems();

    print('_update...');
    setState(() {
      _list = a;
    });
    return;
  }

  @override
  void dispose() {
    //_myCancelableFuture.cancel();
    _updateCancelableFuture.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ItemMedia>>(
      future: _list?.fetchMediaItems(),
      //initialData: [],
      builder: (context, snapshot) => !snapshot.hasData
          ? const CircularProgressIndicator()
          : Column(
              children: [
                AppBar(
                  title: Text(widget.listMedia.mediaType),
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
