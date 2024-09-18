part of 'create_quiz.screen.dart';

class _TypesBox extends StatelessWidget {
  const _TypesBox({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<CreateQuizCubit>().state.filter;
    final cubit = context.read<CreateQuizCubit>();
    return _FilterBox(
      'Types',
      filters: Column(
        children: [
          AppCheckBox(
            value: filter.types.contains('QCM'),
            onChange: (_) => cubit.updateTypes(['QCM']),
            title: 'Question à choix multiple',
          ),
          height(22),
          AppCheckBox(
            value: filter.types.contains('QCU'),
            onChange: (_) => cubit.updateTypes(['QCU']),
            title: 'Question à choix unique',
          ),
        ],
      ),
    );
  }
}
