part of 'create_quiz.screen.dart';

class _FilterBox extends StatefulWidget {
  const _FilterBox(this.title,
      // ignore: unused_element
      {required this.filters, this.additionalText = ''});

  final String title;
  final String additionalText;
  final Widget filters;

  @override
  State<_FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<_FilterBox> {
  bool showFilters = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => setState(() => showFilters = !showFilters),
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(18.r),
                bottom: Radius.circular(showFilters ? 0 : 18.r),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: widget.title,
                      style: context.textStyles.h5.copyWith(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: widget.additionalText,
                          style: context.textStyles.body1,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      setState(() => showFilters = !showFilters),
                  icon: Icon(
                    showFilters
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showFilters)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: 24.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(18.r)),
              border: Border.all(
                width: 0.5,
                color: context.colors.dark.withOpacity(0.5),
              ),
            ),
            child: widget.filters,
          ),
      ],
    );
  }
}
