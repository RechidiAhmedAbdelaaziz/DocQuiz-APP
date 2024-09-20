part of 'create_quiz.screen.dart';

class _TitleField extends StatelessWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context) {
    final controller =
        context.read<CreateQuizCubit>().titleController;
    return SectionBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Titre de quiz', style: context.textStyles.h5),
          height(5),
          AppInputeField(
            hint: 'Entrez le titre de votre quiz',
            controller: controller,
            validator: (value) => value.isValidString,
          ),
        ],
      ),
    );
  }
}
