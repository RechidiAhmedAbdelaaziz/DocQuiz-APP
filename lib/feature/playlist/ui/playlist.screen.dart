import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/home/logic/home.cubit.dart';
import 'package:app/feature/playlist/data/model/playlist.model.dart';
import 'package:app/feature/playlist/logic/playlist.cubit.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/question/helper/question.route.dart';
import 'package:app/feature/quiz/module/quizlist/ui/quiz_list.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playlists = context.watch<PlaylistCubit>().state.playlists;
    return BlocListener<PlaylistCubit, PlaylistState>(
      listener: (context, state) {
        state.onError(context.showWarningSnackBar);
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SectionBox(
          child: Column(
            children: [
              height(10),
              Row(
                children: [
                  const LinedText('Mes Playlist'),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      context.showPopUp(
                        content: NamePopup(
                          title: 'Nom de la playlist',
                          onSave: (title) => context
                              .read<PlaylistCubit>()
                              .createPlaylist(title),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.add,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              height(20),
              AppSearchBar(
                onSearch: (value) =>
                    context.read<PlaylistCubit>().keyword = value,
              ),
              height(35),
              ...playlists.map((playlist) => _PlayListItem(playlist)),
              const _PageIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayListItem extends StatelessWidget {
  final PlaylistModel playlist;

  const _PlayListItem(this.playlist);

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(color: context.colors.dark.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(
            playlist.title!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.textStyles.h5,
          ),
          height(10),
          Text(
            '${playlist.totalQuestions} questions',
            style: context.textStyles.body1.copyWith(
              color: context.colors.dark.withOpacity(0.7),
            ),
          ),
          const Divider(),
          height(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(
                color: Colors.green,
                icon: Icons.play_arrow_rounded,
                onTap: () async {
                  final questions =
                      await context.to<List<QuestionResultModel?>>(
                          QuestionRoute.playlist(playlist));
                  if (questions != null) {
                    homeCubit.showQuestionsResult(
                        playlist.title!, questions);
                  }
                },
              ),
              _buildActionButton(
                color: Colors.teal,
                icon: Icons.edit,
                onTap: () {
                  context.showPopUp(
                    content: NamePopup(
                      initial: playlist.title,
                      title: 'Nom de la playlist',
                      onSave: (title) => context
                          .read<PlaylistCubit>()
                          .updatePlaylist(playlist, title: title),
                    ),
                  );
                },
              ),
              _buildActionButton(
                color: Colors.teal,
                icon: Icons.settings,
                onTap: () {},
              ),
              _buildActionButton(
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  context.showDialogBox(
                    title: 'Supprimer le quiz',
                    body: 'Voulez-vous vraiment supprimer ce quiz?',
                    confirmText: 'Supprimer',
                    onConfirm: (back) {
                      context
                          .read<PlaylistCubit>()
                          .deletePlaylist(playlist);
                      back();
                    },
                    cancelText: 'Annuler',
                    onCancel: (back) => back(),
                  );
                },
              ),
            ],
          ),
          height(5),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 25.r,
        ),
      ),
    );
  }
}

class NamePopup extends StatelessWidget {
  NamePopup({
    required this.onSave,
    String? initial,
    required this.title,
  }) : controller = TextEditingController(text: initial);

  final TextEditingController controller;
  final void Function(String) onSave;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            width: 350.w,
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 22.h),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: context.colors.dark.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colors.dark.withOpacity(0.3),
                  blurRadius: 7.r,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '  $title',
                  style: context.textStyles.h4,
                ),
                height(10),
                TextField(
                  controller: controller,
                  style: context.textStyles.body1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(14.r)),
                    ),
                  ),
                ),
                height(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onSave(controller.text);
                        context.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.dark,
                        foregroundColor: context.colors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        textStyle: context.textStyles.body1,
                      ),
                      child: const Text('Sauvegarder'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) {
    final page = context.watch<PlaylistCubit>().page;
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: context.read<PlaylistCubit>().prevPage,
            icon: Icon(
              Icons.arrow_back_ios,
              color: page <= 1
                  ? context.colors.background
                  : context.colors.dark,
            ),
          ),
          width(23),
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text(
              '$page',
              style: context.textStyles.h5.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          width(23),
          IconButton(
            onPressed: context.read<PlaylistCubit>().nextPage,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: context.colors.dark,
            ),
          ),
        ],
      ),
    );
  }
}
