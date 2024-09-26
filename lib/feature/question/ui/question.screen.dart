import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/bottomsheet.extension.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/timer.dart';
import 'package:app/core/theme/icons.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/core/utils/constants.dart';
import 'package:app/feature/notes/ui/notes.widget.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:app/feature/question/logic/questions.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:app/feature/themes/widget/switch_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_scroll/text_scroll.dart';

part 'header.dart';
part 'choices.dart';
part 'bottom_bar.dart';
part 'progress.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final question = context.watch<QuestionCubit>().state.question;

    if (question == null) {
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
          _Header(question, title),
          height(15),
          _QuestionInfo(question),
          height(30),
          _QuestionText(question),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 35.w, vertical: 5.h),
            child: const Divider(),
          ),
          height(10),
          Expanded(child: _QuestionChoices(question)),
        ],
      ),
      bottomNavigationBar: _BottomBar(question),
      endDrawer: const _Progress(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

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
      : difficulty = question.question.difficulty == 'easy'
            ? 'Facile'
            : question.question.difficulty == 'medium'
                ? 'Moyen'
                : 'Difficile',
        type = question.question.type!,
        source = question.question.source?.name;

  final QuestionResultModel question;

  final String difficulty;
  final String type;
  final String? source;

  @override
  Widget build(BuildContext context) {
    final progres = context.read<QuestionCubit>().state.progres;

    return Column(
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
        if (source != null) ...[
          height(10),
          Row(
            children: [
              width(20),
              _buildSource(),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDifficulty() {
    return _buildInfo(
        difficulty,
        difficulty == 'Facile'
            ? Colors.green
            : difficulty == 'Moyen'
                ? Colors.orange
                : Colors.red);
  }

  Widget _buildType() {
    return _buildInfo(
        type, type == 'QCM' ? Colors.blue : Colors.purple);
  }

  Widget _buildSource() {
    return _buildInfo(
      '$source | ${question.question.year}',
      Colors.teal[600]!,
      isSource: true,
    );
  }

  Widget _buildInfo(String value, Color color,
      {bool isSource = false}) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSource ? color : null,
        borderRadius: BorderRadius.circular(14.r),
        border: isSource ? null : Border.all(color: color),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: isSource ? Colors.white : color,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class _QuestionText extends StatelessWidget {
  const _QuestionText(this.question, {super.key});

  final QuestionResultModel question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
      child: Text(
        question.question.questionText!,
        maxLines: 12,
        overflow: TextOverflow.ellipsis,
        style: context.textStyles.body1,
      ),
    );
  }
}
