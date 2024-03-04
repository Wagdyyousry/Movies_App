import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  late Dio dio;
  ApiServices() {
    dio = Dio(BaseOptions(baseUrl: Constants.upComingMoviesURL));
  }

  Future<MovieModel> getTrendingMovies() async {
    //Using (( Dio ))
    // Response response = await dio.get("");
    // MovieModel1 model = MovieModel1.fromJson(response.data);
    // print("getTrendingMovies=====${model.results.length}");
    // return model;

    //Using (( Http ))
    final response = await http.get(Uri.parse(Constants.trendingMoviesURL));
    MovieModel model = MovieModel.fromJson(jsonDecode(response.body));
    return model;
  }

  Future<MovieModel> getTopRatedMovies() async {
    //Using (( dio ))
    // Response response = await dio2.get("");
    // MovieModel2 model = MovieModel2.fromJson(response.data);
    // //print("=====${model.results.length}");
    // return model;

    //Using (( Http ))
    final response = await http.get(Uri.parse(Constants.topRatedMoviesURL));
    MovieModel model = MovieModel.fromJson(jsonDecode(response.body));
    return model;
    
  }

  Future<MovieModel> getUpcomingMovies() async {
    //Using (( Dio ))
    Response response = await dio.get("");
    MovieModel model = MovieModel.fromJson(response.data);
    
    return model;

    //Using (( Http ))
    // final response = await http.get(Uri.parse(Constants.upComingMoviesURL));
    // MovieModel model = MovieModel.fromJson(jsonDecode(response.body));
    // return model;
    
  }
}
