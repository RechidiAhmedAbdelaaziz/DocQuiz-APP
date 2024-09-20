part of 'create_quiz.screen.dart';

class _SelectedCourses extends StatelessWidget {
  const _SelectedCourses();

  @override
  Widget build(BuildContext context) {
    final courses =
        context.watch<CreateQuizCubit>().state.filter.courses;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 135.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 10.w,
              children: [
                ...courses.map((course) {
                  return Chip(
                    label: Text(
                      course.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    color: const WidgetStatePropertyAll(Colors.teal),
                    
                    deleteIconColor: Colors.white,
                    onDeleted: () {
                      context
                          .read<CreateQuizCubit>()
                          .updateCourses([course]);
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
