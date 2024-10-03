import 'package:app/core/shared/widgets/check_box.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/playlist/logic/playlist_save.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../quiz/module/quizlist/ui/quiz_list.dart';

class SavePlaylist extends StatelessWidget {
  const SavePlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    final playlists =
        context.watch<SavePlaylistCubit>().state.playlists;
    final cubit = context.read<SavePlaylistCubit>();
    return BlocListener<SavePlaylistCubit, SavePlaylistState>(
      listener: (context, state) {
        state.onSaved(() => Navigator.of(context).pop());
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 520.h,
            width: 360.w,
            child: Material(
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
                      onSearch: (value) => context
                          .read<SavePlaylistCubit>()
                          .keyword = value,
                    ),
                    height(15),
                    SizedBox(
                      height: 290.h,
                      child: ListView.builder(
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          final playlist = playlists[index];
                          return AppCheckBox(
                            onChange: (_) =>
                                cubit.selectPlaylist(playlist),
                            title: playlist.title!,
                            value: cubit.state.isSelected(playlist),
                          );
                        },
                      ),
                    ),
                    height(15),
                    SubmitButton(
                      title: 'Enregistrer',
                      onPressed: cubit.submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
