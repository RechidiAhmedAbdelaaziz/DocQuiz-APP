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
          create: (context) => NamesCubit<MajorModel, LevelModel>(),
        ),
        BlocProvider(
          create: (context) => NamesCubit<CourseModel, MajorModel>(),
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
          filters: Column(
            children: [
              SizedBox(
                height: 220.h,
                child: PageView(
                  controller: cubit.pageController,
                  children: state.pages,
                ),
              ),
              const Divider(),
              const _SelectedCourses()
            ],
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
    final cubit = context.read<NamesCubit<MajorModel, LevelModel>>();

    final controller = ScrollController(
      initialScrollOffset:
          context.read<CreateQuizCubit>().levelScroll,
    );

    return NamesSelector(
      controller: controller,
      items: levels,
      highlitedItem: cubit.parent,
      onSelect: (level) {
        context.read<CreateQuizCubit>().levelScroll =
            controller.offset;
        final pageCubit = context.read<PageViewCubit>();
        pageCubit.addPage(
          Builder(builder: (context) {
            final majorsCubit =
                context.read<NamesCubit<MajorModel, LevelModel>>();
            majorsCubit.setParent = level;
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

    final controller = ScrollController(
      initialScrollOffset:
          context.read<CreateQuizCubit>().majorScroll,
    );
    return NamesSelector(
      controller: controller,
      items: majors,
      highlitedItem:
          context.read<NamesCubit<CourseModel, MajorModel>>().parent,
      onSelect: (major) {
        context.read<CreateQuizCubit>().majorScroll =
            controller.offset;
        final pageCubit = context.read<PageViewCubit>();
        pageCubit.addPage(
          Builder(builder: (context) {
            final coursesCubit =
                context.read<NamesCubit<CourseModel, MajorModel>>();
            coursesCubit.setParent = major;
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

    final selected = quizCubit.state.filter.courses;

    void updateQuizName() {
      quizCubit.titleController.text =
          "Quiz sur (${selected.map((e) => e.name).join('+ ')}) | ${DateTime.now()}";
    }

    return NamesSelector(
      items: courses,
      selectedItems: selected,
      onSelect: (course) {
        quizCubit.updateCourses([course]);
        updateQuizName();
      },
      onSelectAll: (selectedAll) {
        if (selectedAll) {
          quizCubit.updateCourses(courses);
        } else {
          quizCubit.updateCourses(
            selected.nonSharedItems(courses),
          );
        }
        updateQuizName();
      },
    );
  }
}
