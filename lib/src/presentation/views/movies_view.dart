import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slash_assignment_movies/src/core/utils/app_responsive.dart';
import 'package:slash_assignment_movies/src/core/utils/constants.dart';
import 'package:slash_assignment_movies/src/core/utils/text_constants.dart';
import 'package:slash_assignment_movies/src/data/models/movie_model.dart';
import 'package:slash_assignment_movies/src/presentation/blocs/movies_bloc.dart';
import 'package:slash_assignment_movies/src/presentation/widgets/movie_widget.dart';

import '../../core/bloc/bloc_with_state.dart';

class MoviesView extends HookWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      WidgetsFlutterBinding.ensureInitialized();
      scrollController
          .addListener(() => _onScrollListener(context, scrollController));
      return scrollController.dispose;
    }, [scrollController]);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(scrollController),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final Function fontSize = ScreenUtils(MediaQuery.of(context)).getFontSize;
    return AppBar(
      backgroundColor: const Color(0xFFf3f3f3),
      automaticallyImplyLeading: false,
      title: Container(
        alignment: Alignment.center,
        child: Text(
          kAppBar,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: fontSize(30),
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (_, state) {
        if (state is MoviesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is MoviesLoadingError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "${state.error?.message.toString()} '\n'  $kSomethingWentWrongDefault",
                textAlign: TextAlign.center,
              )),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // Need to be implemented
                },
                child: const Icon(
                  Ionicons.refresh,
                  size: 35,
                ),
              ),
            ],
          );
        } else if (state is MoviesLoadingDone) {
          return _buildMovies(scrollController,
              state.movies as List<MovieModel>, state.noMoreData ?? false);
        } else if (state is MoviesFetchingNextPage) {
          return _buildMovies(
              scrollController, state.movies as List<MovieModel>, false);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildMovies(
    ScrollController scrollController,
    List<MovieModel> movies,
    bool noMoreData,
  ) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(15),
      children: [
        // Items
        ...List<Widget>.from(
          movies.map(
            (e) => Builder(
              builder: (context) => MovieWidget(
                movie: e,
                onMoviePressed: (e) => _onMoviePressed(context, e),
              ),
            ),
          ),
        ),

        // add Loading (circular progress indicator at the end),
        // if there are more items to be loaded
        if (noMoreData) ...[
          const SizedBox(),
        ] else ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: CupertinoActivityIndicator(
              radius: 20,
            ),
          ),
        ]
      ],
    );
  }

  void _onScrollListener(
      BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);
    final state = moviesBloc.blocProcessState;

    if (currentScroll == maxScroll && state == BlocProcessState.idle) {
      // Fetch more movies
      moviesBloc.add(const GetMoviesEvent(fetchMore: true));
    }
  }

  void _onMoviePressed(BuildContext context, MovieModel movie) {
    // Outside the scope of this assignment
  }
}
