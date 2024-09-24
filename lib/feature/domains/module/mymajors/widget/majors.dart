import 'package:app/app.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/module/mymajors/logic/my_majors.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyMajors extends StatelessWidget {
  const MyMajors({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyMajorsCubit()..fetchMajors(),
      child: _MjoarList(),
    );
  }
}

class _MjoarList extends StatefulWidget {
  const _MjoarList({super.key});

  @override
  State<_MjoarList> createState() => _MjoarListState();
}

class _MjoarListState extends State<_MjoarList> {
  MajorModel? slectedMajor;

  @override
  Widget build(BuildContext context) {
    final majors =
        context.select((MyMajorsCubit cubit) => cubit.state.majors);
    return Column(
      children: [
        const LinedText('Les Modules'),
        height(12),
        Expanded(
          child: ListView.builder(
            itemCount: majors.length,
            itemBuilder: (context, index) {
              final major = majors[index];
              return Column(
                children: [
                  Row(
                    children: [
                      width(12),
                      Expanded(
                        child: Text(
                          major.name,
                          style: context.textStyles.h4,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            slectedMajor = major;
                          });
                        },
                        icon: Icon(
                          major == slectedMajor
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: context.colors.dark,
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                  if (major == slectedMajor)
                    BlocBuilder<MyMajorsCubit, MyMajorsState>(
                      builder: (context, state) {
                        final courses = state.coursesFor(major);
                        if (courses == null) {
                          context
                              .read<MyMajorsCubit>()
                              .fetchCourses(major);
                          return const LinearProgressIndicator(
                            backgroundColor: Colors.teal,
                          );
                        }
                        return Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: courses
                              .map((course) => Container(
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color:
                                          context.colors.background,
                                      borderRadius:
                                          BorderRadius.circular(16.r),
                                      border: Border.all(
                                        color: context.colors.dark,
                                        // width: 0.7,
                                      ),
                                    ),
                                    child: Text(
                                      course.name,
                                      style: context.textStyles.body1,
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
