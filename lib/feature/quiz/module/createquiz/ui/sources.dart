part of 'create_quiz.screen.dart';

class _SourcesBox extends StatelessWidget {
  const _SourcesBox();

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<CreateQuizCubit>().state.filter;
    return _FilterBox(
      'Sources',
      filters: Column(
        children: [
          BlocProvider(
            create: (context) =>
                NamesCubit<SourceModel, void>()..fetchAll(),
            child: const _Sources(),
          ),
          height(22),
          AppDropDown(
            title: 'A partir de l\'année :',
            items: [
              for (var i = DateTime.now().year; i >= 2000; i--)
                i.toString()
            ],
            value: filter.year.toString(),
            onChanged: (value) {
              context
                  .read<CreateQuizCubit>()
                  .updateYear(int.parse(value!));
            },
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }
}

class _Sources extends StatelessWidget {
  const _Sources();

  @override
  Widget build(BuildContext context) {
    final sources =
        context.watch<NamesCubit<SourceModel, void>>().state.items;
    return NamesSelector(
      items: sources,
      onSelect: (value) {
        context.read<CreateQuizCubit>().updateSource([value]);
      },
      canSelect: true,
      selectedItems:
          context.watch<CreateQuizCubit>().state.filter.sources,
      onSelectAll: () {
        context.read<CreateQuizCubit>().updateSource(sources);
      },
    );
  }
}

class AppDropDown extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String?) onChanged;
  final Icon? icon;
  final String? value;

  const AppDropDown({
    required this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textStyles.body1,
        ),
        height(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              icon ?? const SizedBox(),
              width(12),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  value: value,
                  items: items
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
