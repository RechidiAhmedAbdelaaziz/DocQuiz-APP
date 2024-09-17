part of 'create_quiz.screen.dart';

class _PreferenceBox extends StatelessWidget {
  const _PreferenceBox();

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<CreateQuizCubit>().state.filter;
    final cubit = context.read<CreateQuizCubit>();
    return _FilterBox(
      'Préférences',
      filters: Column(
        children: [
          AppCheckBox(
            value: filter.alreadyAnsweredFalse,
            onChange: cubit.updateAlreadyAnsweredFalse,
            title: 'Questions déjà fausses',
          ),
          height(22),
          AppCheckBox(
            value: filter.withExplanation,
            onChange: cubit.updateWithExplain,
            title: 'Questions avec explication',
          ),
          height(22),
          AppCheckBox(
            value: filter.withNotes,
            onChange: cubit.updateWithNote,
            title: 'Questions avec note',
          ),
        ],
      ),
    );
  }
}
