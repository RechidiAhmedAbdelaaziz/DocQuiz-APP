import 'package:app/core/extension/validator.extension.dart';
import 'package:app/core/shared/widgets/check_box.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/theme/spaces.dart';
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

class CreateQuizScreen extends StatelessWidget {
  const CreateQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
            height(45),
          ],
        ),
      ),
    );
  }
}
