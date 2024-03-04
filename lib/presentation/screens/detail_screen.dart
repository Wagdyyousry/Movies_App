import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/utils/constants.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  Result movie;
  DetailsScreen({required this.movie, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Result? movie;

  @override
  void initState() {
    movie = widget.movie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat("dd-MM-yyyy hh:mm a");
    final releaseDate = df.format(movie!.releaseDate);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 12,
            shadowColor: Colors.black,

            leading: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(top: 7, left: 7),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            expandedHeight: 450,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie!.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              background: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(50)),
                child: movie!.posterPath.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'images/loader5.gif',
                        image: Constants.imagePath + movie!.posterPath,
                      )
                    : Image.asset(
                        'images/loader5.gif',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    "Overview",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationStyle: TextDecorationStyle.double,
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    movie!.overview,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "Release Date",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationStyle: TextDecorationStyle.double,
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      releaseDate,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 200)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void emptyFun(){
    
  }
}
