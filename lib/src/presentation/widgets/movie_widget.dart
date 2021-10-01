import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slash_assignment_movies/src/core/utils/app_responsive.dart';
import 'package:slash_assignment_movies/src/data/models/movie_model.dart';

class MovieWidget extends StatelessWidget {
  final MovieModel? movie;

  final void Function(MovieModel movie)? onMoviePressed;

  const MovieWidget({
    Key? key,
    this.movie,
    this.onMoviePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Need to put this in one place and call init instead using it all view files
    // Short on time
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function fontSize = ScreenUtils(MediaQuery.of(context)).getFontSize;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Card(
        elevation: 5,
        child: SizedBox(
          height: hp(25),
          child: Row(
            children: [
              _buildImage(context),
              _buildTitleAndDescriptionGenre(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
          ),
          child: Image.network(
            movie?.mediumCoverImage ?? '',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Text(
                  '404\nNOT FOUND',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescriptionGenre(BuildContext context) {
    // Need to put this in one place and call init instead using it all view files
    // Short on time
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function fontSize = ScreenUtils(MediaQuery.of(context)).getFontSize;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: hp(1), horizontal: wp(1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              movie?.titleLong ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: fontSize(20),
                color: Colors.black87,
              ),
            ),
            // Description
            Text(
              movie?.descriptionFull ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSize(20),
                color: Colors.black87,
              ),
            ),

            // Ratings

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: RatingBarIndicator(
                  rating: getRating(),
                  itemBuilder: (context, index) => const Icon(
                    Ionicons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: wp(5),
                  direction: Axis.horizontal,
                ),
              ),
            ),

            // Genre
            Text(getGenreAsString()),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (onMoviePressed != null) {
      onMoviePressed!(movie!);
    }
  }

  double getRating() {
    if (movie != null) {
      // Dividing by 2 as we have 5 stars and rating is on the scale of 1 to 10
      return double.parse(movie!.rating.toString()) / 2;
    } else {
      return 0;
    }
  }

  String getGenreAsString() {
    List<String> genre = movie?.genres ?? [];
    String genreString = '';
    for (int i = 0; i < genre.length; i++) {
      if (i == genre.length - 1) {
        genreString = genreString + genre[i];
      } else {
        genreString = genreString + genre[i] + ' ' + '|' + ' ';
      }
    }
    print(genreString);
    return genreString;
  }
}
