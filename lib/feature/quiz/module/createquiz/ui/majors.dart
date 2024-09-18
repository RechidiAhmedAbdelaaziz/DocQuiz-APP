part of 'create_quiz.screen.dart';

class _MajorsBox extends StatefulWidget {
  _MajorsBox({super.key});

  @override
  State<_MajorsBox> createState() => _MajorsBoxState();
}

class _MajorsBoxState extends State<_MajorsBox> {
  final List<Widget> pages = [];
  final controller = PageController();

  @override
  void initState() {
    pages.add(__MajorsBox(
      addpage: (major) async {
        if (pages.length > 1) {
          pages.removeLast();
        }
        final newCoursePage = _CoursesBox(major);

        setState(() {
          pages.add(newCoursePage);
          controller.jumpToPage(pages.length - 1);
        });
      },
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NamesCubit<MajorModel, DomainModel>()..fetchAll(),
      child: _FilterBox(
        'Les modules',
        filters: SizedBox(
          height: 180.h,
          child: Builder(builder: (context) {
            return PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: pages,
            );
          }),
        ),
      ),
    );
  }
}

class __MajorsBox extends StatelessWidget {
  const __MajorsBox({super.key, required this.addpage});

  final void Function(MajorModel) addpage;

  @override
  Widget build(BuildContext context) {
    final majors = context
        .watch<NamesCubit<MajorModel, DomainModel>>()
        .state
        .items;
    return NamesSelector(
      items: majors,
      onSelect: (value) {
        addpage(value);
      },
      canSelect: false,
    );
  }
}

class _CoursesBox extends StatelessWidget {
  const _CoursesBox(this.major, {super.key});

  final MajorModel major;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NamesCubit<CourseModel, MajorModel>()
        ..fetchAll(parent: major),
      child: Builder(builder: (context) {
        final selected =
            context.watch<CreateQuizCubit>().state.filter.courses;
        final courses = context
            .watch<NamesCubit<CourseModel, MajorModel>>()
            .state
            .items;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalDivider(),
            Expanded(
              child: NamesSelector(
                items: courses,
                onSelect: (value) {
                  context
                      .read<CreateQuizCubit>()
                      .updateCourses([value]);
                  final titleController =
                      context.read<CreateQuizCubit>().titleController;

                  titleController.text =
                      'Revision ${selected.map((e) => '${e.name}, ').toString()} | ${DateTime.now().toString()}';
                },
                selectedItems: selected,
              ),
            ),
          ],
        );
      }),
    );
  }
}
