part of 'create_quiz.screen.dart';

class _MajorsBox extends StatelessWidget {
  const _MajorsBox();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NamesCubit<LevelModel, void>()..fetchAll(),
        ),
        BlocProvider(
          create: (context) =>
              NamesCubit<MajorModel, LevelModel>(),
        ),
        BlocProvider(
          create: (context) =>
              NamesCubit<CourseModel, MajorModel>(),
        ),
        BlocProvider(
          create: (context) =>
              PageViewCubit()..addPage(const _LevelsPage()),
        ),
      ],
      child: BlocBuilder<PageViewCubit, PageViewState>(
          builder: (context, state) {
        final cubit = context.read<PageViewCubit>();
        return _FilterBox(
          'Les modules',
          filters: SizedBox(
            height: 220.h,
            child: PageView(
              controller: cubit.pageController,
              children: state.pages,
            ),
          ),
        );
      }),
    );
  }
}

class _LevelsPage extends StatelessWidget {
  const _LevelsPage();

  @override
  Widget build(BuildContext context) {
    final levels =
        context.watch<NamesCubit<LevelModel, void>>().state.items;
    return NamesSelector(
      items: levels,
      onSelect: (level) {
        final pageCubit = context.read<PageViewCubit>();
        pageCubit.addPage(
          Builder(builder: (context) {
            final majorsCubit =
                context.read<NamesCubit<MajorModel, LevelModel>>();
            majorsCubit.parent = level;
            return const _MajorsPage();
          }),
          replaceIndex: 1,
        );
        pageCubit.setCurrentPage(1);
      },
    );
  }
}

class _MajorsPage extends StatelessWidget {
  const _MajorsPage();

  @override
  Widget build(BuildContext context) {
    final majors = context
        .watch<NamesCubit<MajorModel, LevelModel>>()
        .state
        .items;
    return NamesSelector(
      items: majors,
      onSelect: (major) {
        final pageCubit = context.read<PageViewCubit>();
        pageCubit.addPage(
          Builder(builder: (context) {
            final coursesCubit =
                context.read<NamesCubit<CourseModel, MajorModel>>();
            coursesCubit.parent = major;
            return const _CoursePage();
          }),
          replaceIndex: 2,
        );
        pageCubit.setCurrentPage(2);
      },
    );
  }
}

class _CoursePage extends StatelessWidget {
  const _CoursePage();

  @override
  Widget build(BuildContext context) {
    final courses = context
        .watch<NamesCubit<CourseModel, MajorModel>>()
        .state
        .items;
    final quizCubit = context.watch<CreateQuizCubit>();

    return NamesSelector(
      items: courses,
      selectedItems: quizCubit.state.filter.courses,
      onSelect: (course) {
        quizCubit.updateCourses([course]);
      },
      onSelectAll: () {
        quizCubit.updateCourses(courses);
      },
    );
  }
}
