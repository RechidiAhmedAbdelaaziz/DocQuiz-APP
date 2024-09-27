import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/feature/playlist/logic/playlist.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../quiz/module/quizlist/ui/quiz_list.dart';

class SavePlaylist extends StatelessWidget {
  const SavePlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SectionBox(
        child: Column(
          children: [
            Text(
              'Modifier les playlists',
              style: context.textStyles.h4,
            ),
            const Divider(),
            AppSearchBar(
              onSearch: (value) =>
                  context.read<PlaylistCubit>().keyword = value,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
