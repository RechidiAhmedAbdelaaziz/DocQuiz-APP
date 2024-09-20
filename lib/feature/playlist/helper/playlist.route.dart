import 'package:app/core/router/routebase.dart';
import 'package:app/feature/playlist/logic/playlist.cubit.dart';
import 'package:app/feature/playlist/ui/playlist.screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayListRoute extends DrawerRoute {
  PlayListRoute()
      : super(
          child: BlocProvider(
            create: (_) => PlaylistCubit()..fetchPlaylists(),
            child: const PlayListScreen(),
          ),
        );
}
