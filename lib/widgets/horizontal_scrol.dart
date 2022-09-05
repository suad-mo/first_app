import 'package:first_app/models/enums/enums.dart';
import 'package:first_app/models/item_media.dart';
import 'package:first_app/models/list_media.dart';
import 'package:first_app/providers/lists/trending_movie_week.dart';
import 'package:first_app/providers/medias_provider.dart';
import 'package:first_app/providers/movies/list_type_movies.dart';
import 'package:first_app/widgets/horizontal_scrol/scroll_media.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_app/providers/movies/trending_week_movies.dart';

class HorizontalSsroll extends StatelessWidget {
  const HorizontalSsroll({Key? key}) : super(key: key);
  static const routeName = '/horizontal-scroll';
  // final BuildContext ctx;
  //final moviePopolar = ListMedia(mediaType: 'movie/popular');

  @override
  Widget build(BuildContext context) {
    Provider.of<TrendingMovieWeek>(context, listen: false);
    final mediasProvider = Provider.of<MediasProvider>(context, listen: false);
    final popularMovie = mediasProvider.itemsPopularMovie;
    final trendingItems = mediasProvider.itemsTrendingMoviesWeek;
    final upcomingItems = mediasProvider.itemsUpcomingMovie;

    print('Popular Movie count: ${popularMovie.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal scrol'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScrollMedia(ListMediaType.movieNowPlaying),
            ScrollMedia(ListMediaType.tvAiringToday),
            HorizontalScrollWidget(popularMovie: popularMovie),
            const SizedBox(
              height: 10,
            ),
            HorizontalScrollWidget(popularMovie: trendingItems),
            const SizedBox(
              height: 10,
            ),
            HorizontalScrollWidget(popularMovie: upcomingItems),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: RefreshIndicator(
                edgeOffset: 20,
                color: Colors.yellow,
                onRefresh: (() async {}),
                child: Consumer<TrendingWeekMovies>(
                  builder: (context, movies, child) {
                    print('Hoizontalscrol listing broj: ${movies.countMovies}');
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: movies.countMovies,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 100,
                        color: Colors.green,
                        child: Center(
                          child: Text(movies.listMovies()[index].title!),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<MediasProvider>(
              builder: (context, movies, child) => Container(
                width: double.infinity,
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: RefreshIndicator(
                    edgeOffset: 20,
                    color: Colors.yellow,
                    onRefresh: movies.nextPagePopularMovie,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: movies.popularMovie.items.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 100,
                        color: Colors.green,
                        child: Center(
                          child: Text(movies.popularMovie.items[index].title),
                        ),
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<MediasProvider>(
              builder: (context, movies, child) {
                final items = movies.itemsPopularMovie;
                return Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: RefreshIndicator(
                      edgeOffset: 20,
                      color: Colors.yellow,
                      onRefresh: movies.nextPagePopularMovie,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 100,
                          color: Colors.green,
                          child: Center(
                            child: Text(items[index].title),
                          ),
                        ),
                      )),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: RefreshIndicator(
                edgeOffset: 20,
                color: Colors.yellow,
                onRefresh: (() async {}),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: ((context, i) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 100,
                        color: Colors.green,
                        child: Center(
                          child: Text(i.toString()),
                        ));
                  }),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    // height: 50,
                    width: 150,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(8),
                  ),
                  Container(
                    // height: 50,
                    width: 120,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(8),
                  ),
                  Container(
                    // height: 50,
                    width: 120,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(8),
                  ),
                  Container(
                    // height: 50,
                    width: 120,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(8),
                  ),
                  Container(
                    // height: 50,
                    width: 120,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(8),
                  ),
                  Container(
                    // height: 50,
                    width: 120,
                    color: Colors.amber,
                    margin: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: RefreshIndicator(
                edgeOffset: 20,
                color: Colors.yellow,
                onRefresh: (() async {}),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: ((context, index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 100,
                        color: Colors.green,
                        child: Center(child: Text((index + 1).toString())),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HorizontalScrollWidget extends StatelessWidget {
  const HorizontalScrollWidget({
    Key? key,
    required this.popularMovie,
  }) : super(key: key);

  final List<ItemMedia> popularMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: RefreshIndicator(
        edgeOffset: 20,
        color: Colors.yellow,
        onRefresh: (() async {}),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: popularMovie.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            width: 100,
            color: Colors.green,
            child: Image(
              image: NetworkImage(popularMovie[index].posterPath),
              fit: BoxFit.cover,
            ),
            // child: Text(popularMovie[index].title),
          ),
        ),
      ),
    );
  }
}

class HorizontalScroll extends StatelessWidget {
  const HorizontalScroll({
    Key? key,
    required this.trendingItems,
  }) : super(key: key);

  final List<ItemMedia> trendingItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: RefreshIndicator(
        edgeOffset: 20,
        color: Colors.yellow,
        onRefresh: (() async {}),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: trendingItems.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 100,
            color: Colors.green,
            child: Center(
              child: Text(trendingItems[index].title),
            ),
          ),
        ),
      ),
    );
  }
}
