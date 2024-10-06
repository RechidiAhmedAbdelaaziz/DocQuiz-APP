import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/bottomsheet.extension.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/timer.dart';
import 'package:app/core/theme/icons.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/core/utils/constants.dart';
import 'package:app/feature/notes/ui/notes.widget.dart';
import 'package:app/feature/playlist/logic/playlist_save.cubit.dart';
import 'package:app/feature/playlist/ui/save_playlist.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/question/logic/questions.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:app/feature/themes/widget/switch_themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_scroll/text_scroll.dart';

part 'header.dart';
part 'choices.dart';
part 'bottom_bar.dart';
part 'progress.dart';
part 'questions.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final questionResult =
        context.watch<QuestionCubit>().state.question;

    if (questionResult == null) {
      return SafeArea(
        child: Scaffold(
          body: LinearProgressIndicator(
            color: Colors.teal,
            minHeight: 10.h,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const _AppBar(),
      body: Column(
        children: [
          _Header(questionResult, title),
          height(15),
          _QuestionInfo(questionResult.question),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  height(8),
                  _Text(questionResult.question.caseText),
                  height(6),
                  _Questions(questionResult),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomBar(questionResult),
      endDrawer: const _Progress(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    bool isFullScreen = false;
    return AppBar(
      backgroundColor: Colors.teal,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            AppIcons.logo,
            height: 55.h,
          ),
          Image.asset(
            AppIcons.name,
            height: 36.h,
          ),
        ],
      ),
      actions: [
        const SwitchThemesButton(),
        width(20),
        InkWell(
          onTap: () {
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: isFullScreen ? SystemUiOverlay.values : [],
            );

            isFullScreen = !isFullScreen;
          },
          child: CircleAvatar(
            backgroundColor: Colors.teal[600],
            radius: 20.w,
            child: const Icon(
              Icons.fullscreen,
              color: Colors.white,
            ),
          ),
        ),
        width(20),
        InkWell(
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 20.w,
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          onTap: () {
            context.showDialogBox(
              title: 'Quitter',
              body: 'Voulez-vous vraiment quitter le test ?',
              confirmText: 'Oui',
              onConfirm: (back) {
                back();
                context.back(
                  context.read<QuestionCubit>().state.questions,
                );
              },
              cancelText: 'Non',
              onCancel: (back) {
                back();
              },
            );
          },
        ),
        width(10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _QuestionInfo extends StatelessWidget {
  _QuestionInfo(this.question)
      : difficulty = question.questions?.length == 1
            ? question.questions![0].difficulty == 'easy'
                ? 'Facile'
                : question.questions![0].difficulty == 'medium'
                    ? 'Moyen'
                    : 'Difficile'
            : null,
        type = question.type!,
        source = question.sources
                ?.map((e) =>
                    '${e.source?.name ?? ''}${e.year! > 0 ? '| ${e.year}' : ''}')
                .toList() ??
            [];

  final QuestionModel question;

  final String? difficulty;
  final String type;
  final List<String> source;

  @override
  Widget build(BuildContext context) {
    final progres = context.read<QuestionCubit>().state.progress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  width(22),
                  Text(
                    progres,
                    style: context.textStyles.body1,
                  ),
                  width(25),
                  _buildType(),
                  width(12),
                  _buildDifficulty(),
                  // const Spacer(),
                  //button to open drawer
                ],
              ),
              Positioned(
                right: -12.w,
                child: InkWell(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 15.w,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        height(10),
        _buildSource(),
      ],
    );
  }

  Widget _buildDifficulty() {
    return _buildInfo(
      difficulty,
      difficulty == 'Facile'
          ? Colors.green
          : difficulty == 'Moyen'
              ? Colors.deepOrange
              : Colors.red,
    );
  }

  Widget _buildType() {
    return _buildInfo(
        type, type == 'QCM' ? Colors.blue : Colors.purple);
  }

  Widget _buildSource() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: source
            .map(
              (e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: _buildInfo(
                  e,
                  Colors.teal,
                  isSource: true,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildInfo(String? value, Color color,
      {bool isSource = false}) {
    if (value == null) return const SizedBox.shrink();
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSource ? color : null,
        borderRadius: BorderRadius.circular(14.r),
        border:
            isSource ? null : Border.all(color: color, width: 1.4),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: isSource ? Colors.white : color,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(this.text);

  final String? text;

  @override
  Widget build(BuildContext context) {
    if (text == null) return const SizedBox.shrink();
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
          child: Text(text!,
              maxLines: 120,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.body2.copyWith(
                fontSize: 20.sp,
              )),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 35.w, vertical: 5.h),
          child: const Divider(),
        ),
      ],
    );
  }
}
