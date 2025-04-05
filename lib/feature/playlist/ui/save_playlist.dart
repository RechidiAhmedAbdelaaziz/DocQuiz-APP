import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/shared/widgets/check_box.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/themes/spaces.dart';
import 'package:app/feature/auth/module/forgetpassword/ui/forget_password.screen.dart';
import 'package:app/feature/playlist/logic/playlist_save.cubit.dart';
import 'package:app/feature/playlist/ui/playlist.screen.dart';
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
        state.onSaved(() {
          context.showSuccessSnackBar('Playlist enregistrée');
          Navigator.of(context).pop();
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            // height: 540.h,
            width: 360.w,
            child: Material(
              color: Colors.transparent,
              child: SectionBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Modifier les playlists',
                        style: context.textStyles.h4,
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: AppSearchBar(
                              onSearch: (value) => context
                                  .read<SavePlaylistCubit>()
                                  .keyword = value,
                            ),
                          ),
                          width(12),
                          InkWell(
                            onTap: () {
                              context.showPopUp(
                                content: NamePopup(
                                  title: 'Ajouter une playlist',
                                  hintText: 'Nom de la playlist',
                                  onSave: (title) => context
                                      .read<SavePlaylistCubit>()
                                      .createPlaylist(title),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.spMin,
                              backgroundColor: Colors.teal,
                              child: Icon(
                                Icons.add,
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                        ],
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
          ),
        ],
      ),
    );
  }
}
