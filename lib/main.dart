import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bussiness_logic/cubit/movie_cubit.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/presentation/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesRepo moviesRepo = MoviesRepo();
    final MovieCubit movieCubit = MovieCubit(moviesRepo);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => movieCubit,
        child: const HomePage(),
      ),
    );
  }
}
