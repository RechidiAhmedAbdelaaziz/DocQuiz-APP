part of 'create_quiz.screen.dart';

class _DifficultiesBox extends StatelessWidget {
  const _DifficultiesBox();

  @override
  Widget build(BuildContext context) {
    final difficulties =
        context.watch<CreateQuizCubit>().state.filter.difficulties;
    final cubit = context.read<CreateQuizCubit>();
    return _FilterBox(
      'Difficulté',
      filters: Column(
        children: [
          AppCheckBox(
            value: difficulties.contains('easy'),
            onChange: (_) => cubit.updateDifficulties(['easy']),
            title: 'Facile',
          ),
          height(22),
          AppCheckBox(
            value: difficulties.contains('medium'),
            onChange: (_) => cubit.updateDifficulties(['medium']),
            title: 'Moyen',
          ),
          height(22),
          AppCheckBox(
            value: difficulties.contains('hard'),
            onChange: (_) => cubit.updateDifficulties(['hard']),
            title: 'Difficile',
          ),
        ],
      ),
    );
  }
}
