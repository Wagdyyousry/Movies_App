import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/repository/movies_repo.dart';

class MovieController extends GetxController {
  final MoviesRepo moviesRepo = MoviesRepo();
  RxBool loadingTrendingMovies = true.obs;
  RxBool loadingTopRatedMovies = true.obs;
  RxBool loadingUpcomingMovies = true.obs;
  Rx<MovieModel> topRatedMovies = MovieModel.empty().obs;
  Rx<MovieModel> trendingMovies = MovieModel.empty().obs;
  Rx<MovieModel> upcomingMovies = MovieModel.empty().obs;

  static MovieController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    getTrendingMovies();
    getTopRatedMovies();
    getUpcomingMovies();
  }

  Future<void> getTrendingMovies() async {
    await moviesRepo.getTrendingMovies().then(
          (movieModel) =>
              {trendingMovies.value = movieModel, loadingTrendingMovies.value = false},
        );
    //return trendingMovies;
  }

  Future<void> getTopRatedMovies() async {
    await moviesRepo.getTopRatedMovies().then(
          (movieModel) => {
            topRatedMovies.value = movieModel,
            loadingTopRatedMovies.value = false
          },
        );
  }

  Future<void> getUpcomingMovies() async {
    await moviesRepo.getUpcomingMovies().then(
          (movieModel) => {
            upcomingMovies.value = movieModel,
            loadingUpcomingMovies.value = false
          },
        );
  }
}
