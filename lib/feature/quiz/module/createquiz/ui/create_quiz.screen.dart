import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/validator.extension.dart';
import 'package:app/core/shared/logic/pageview/page_view.cubit.dart';
import 'package:app/core/shared/widgets/check_box.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/shared/widgets/names_selector.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/logic/names.cubit.dart';
import 'package:app/feature/home/logic/home.cubit.dart';
import 'package:app/feature/question/helper/question.route.dart';
import 'package:app/feature/quiz/module/createquiz/logic/create_quiz.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'sources.dart';
part 'filter_box.dart';
part 'title.dart';
part 'types.dart';
part 'difficulties.dart';
part 'preference.dart';
part 'majors.dart';
part 'selected_course.dart';

class CreateQuizScreen extends StatelessWidget {
  const CreateQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isCreating =
        context.watch<CreateQuizCubit>().state.isCreating;

    if (isCreating) {
      return BlocListener<CreateQuizCubit, CreateQuizState>(
        listener: (context, state) {
          state.onCreated((newQuiz) {
            context.read<HomeCubit>().showMyQuiz();
            context.to(QuestionRoute.quiz(newQuiz));
          });
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Colors.teal),
          ),
        ),
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              height(25),
              const _TitleField(),
              height(45),
              SectionBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(12),
                    Text(
                      'Inclure les questions par :',
                      style: context.textStyles.h5,
                    ),
                    height(25),
                    const _MajorsBox(),
                    height(25),
                    const _SourcesBox(),
                    height(25),
                  ],
                ),
              ),
              height(45),
              SectionBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(12),
                    Text(
                      'Filtrer les questions par :',
                      style: context.textStyles.h5,
                    ),
                    height(25),
                    const _TypesBox(),
                    height(25),
                    const _DifficultiesBox(),
                    height(25),
                    const _PreferenceBox(),
                    height(25),
                  ],
                ),
              ),
              height(100),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(12.r)),
                color: context.theme.colors.primary,
                border: Border(
                  top: BorderSide(
                      color:
                          context.theme.colors.dark.withOpacity(0.7),
                      width: 0.4),
                )),
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    context.watch<CreateQuizCubit>().state.isloading
                        ? SizedBox(
                            width: 35.w,
                            child: const LinearProgressIndicator(
                                color: Colors.teal),
                          )
                        : Text(
                            context
                                .watch<CreateQuizCubit>()
                                .state
                                .questionNumber
                                .toString(),
                            style: context.textStyles.h5
                                .copyWith(color: Colors.teal),
                          ),
                    Text(
                      'Questions',
                      style: context.textStyles.body1,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    context.read<CreateQuizCubit>().createQuiz();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: context
                                  .watch<CreateQuizCubit>()
                                  .state
                                  .questionNumber ==
                              0
                          ? Colors.teal.withOpacity(0.5)
                          : Colors.teal,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      'Construire',
                      style: context.textStyles.body1.copyWith(
                        color: context
                                    .watch<CreateQuizCubit>()
                                    .state
                                    .questionNumber ==
                                0
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
