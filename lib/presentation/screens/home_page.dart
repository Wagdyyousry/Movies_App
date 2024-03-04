import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:movies_app/data/controller/movie_controller.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/presentation/screens/detail_screen.dart';
import 'package:movies_app/presentation/widgets/appBar_widget.dart';
import 'package:movies_app/presentation/widgets/cshimmer.dart';
import 'package:movies_app/presentation/widgets/heading.dart';
import 'package:movies_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieController());
    return Scaffold(
      appBar: const AppBarWiget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderTitle(title: "Trending Movies"),
            Obx(
              () => SizedBox(
                child: controller.loadingTrendingMovies.value
                    ? const CShimmerEffect()
                    : moviesWidget(controller.trendingMovies.value, "trending"),
              ),
            ),

            //Upcoming movies List
            const HeaderTitle(title: "Upcoming Movies"),
            Obx(
              () => SizedBox(
                child: controller.loadingUpcomingMovies.value
                    ? const CShimmerEffect()
                    : moviesWidget(controller.upcomingMovies.value, "upcoming"),
              ),
            ),

            //TopRated movies List
            const HeaderTitle(title: "Top Rated Movies"),
            Obx(
              () => SizedBox(
                child: controller.loadingTopRatedMovies.value
                    ? const CShimmerEffect()
                    : moviesWidget(controller.topRatedMovies.value, "topRated"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moviesWidget(MovieModel data, String movieType) {
    if (data.results.isNotEmpty) {
      if (movieType == "trending") {
        return SizedBox(
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: data.results.length,
            itemBuilder: (context, index, realIndex) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(movie: data.results[index]),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 160,
                    color: Colors.black,
                    child: data.results[index].posterPath.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'images/loader1.gif',
                            image: Constants.imagePath +
                                data.results[index].posterPath,
                          )
                        : Image.asset(
                            'images/loader1.gif',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.50,
              autoPlayCurve: Curves.fastOutSlowIn,
              height: 250,
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
            ),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10),
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.results.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(movie: data.results[index]),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 150,
                      color: Colors.blue,
                      child: data.results[index].posterPath.isNotEmpty
                          ? FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: 'images/loader1.gif',
                              image: Constants.imagePath +
                                  data.results[index].posterPath,
                            )
                          : Image.asset(
                              'images/loader1.gif',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    }
    return const CShimmerEffect();
  }
}


//With bloc => cubit

/* import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bussiness_logic/cubit/movie_cubit.dart';
import 'package:movies_app/data/controller/movie_controller.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/presentation/screens/detail_screen.dart';
import 'package:movies_app/presentation/widgets/appBar_widget.dart';
import 'package:movies_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieModel trendingMovies;
  late MovieModel topRatedMovies;
  late MovieModel upcomingMovies;

  @override
  void initState() {
    super.initState();

    getData();
    // BlocProvider.of<MovieCubit>(context).getTrendingMovies();
    // BlocProvider.of<MovieCubit>(context).getTopRatedMovies();
    // BlocProvider.of<MovieCubit>(context).getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final controller = MovieController.instance;
    return Scaffold(
      appBar: const AppBarWiget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: const Text(
                "Trending Movies",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is TrendingMoviesLoaded) {
                    trendingMovies = state.trendingMovies;
                    return trendingMoviesWidget(trendingMovies);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Text(
                "Top Rated Movies",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoaded) {
                    topRatedMovies = state.topRatedMovies;

                    return topRatedMoviesWidget(topRatedMovies);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Text(
                "Upcoming Movies",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is UpcomingMoviesLoaded) {
                    upcomingMovies = state.upcomingMovies;

                    return upomingMoviesWidget(upcomingMovies);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

            // const SizedBox(
            //   width: 150,
            //   child: Divider(
            //     color: Colors.blue,
            //     thickness: 2.5,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget trendingMoviesWidget(MovieModel data) {
    print("Trending======${data.results[0].title}\n");

    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (context, index, realIndex) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(movie: data.results[index]),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 160,
                color: Colors.black,
                child: data!.results[index].posterPath.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'images/loader1.gif',
                        image: Constants.imagePath +
                            data.results[index].posterPath,
                      )
                    : Image.asset(
                        'images/loader1.gif',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 0.50,
          autoPlayCurve: Curves.fastOutSlowIn,
          height: 250,
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      ),
    );
  }

  Widget topRatedMoviesWidget(MovieModel? data) {
    print("TopRated======${data!.results[0].title}\n");

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data?.results.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(movie: data.results[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 150,
                  color: Colors.blue,
                  child: data!.results[index].posterPath.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'images/loader1.gif',
                          image: Constants.imagePath +
                              data.results[index].posterPath,
                        )
                      : Image.asset(
                          'images/loader1.gif',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget upomingMoviesWidget(MovieModel? data) {
    print("Upcoming======${data!.results[0].title}\n");

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(movie: data.results[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 150,
                  height: 200,
                  color: Colors.blue,
                  child: data!.results[index].posterPath.isNotEmpty
                      ? FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'images/loader1.gif',
                          image: Constants.imagePath +
                              data.results[index].posterPath,
                        )
                      : Image.asset(
                          'images/loader1.gif',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getData() async {
    await BlocProvider.of<MovieCubit>(context).getTrendingMovies();
    await BlocProvider.of<MovieCubit>(context).getTopRatedMovies();
    await BlocProvider.of<MovieCubit>(context).getUpcomingMovies();
  }
} */


