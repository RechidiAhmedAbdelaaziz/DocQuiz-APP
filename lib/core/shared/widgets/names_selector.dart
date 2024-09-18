import 'package:app/core/shared/widgets/check_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NamesSelector<T extends NamedModel> extends StatelessWidget {
  const NamesSelector({
    super.key,
    required this.items,
    required this.onSelect,
    this.canSelect = true,
    this.selectedItems = const [],
    this.onSelectAll,
  })  : canSelectAll = onSelectAll != null,
        selectedAll = selectedItems.length == items.length;

  final List<T> items;
  final List<T> selectedItems;
  final ValueChanged<T> onSelect;
  final VoidCallback? onSelectAll;
  final bool canSelectAll;
  final bool canSelect;
  final bool selectedAll;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (canSelectAll)
            AppCheckBox(
              value: selectedAll,
              onChange: (_) => onSelectAll!(),
              title: selectedAll
                  ? 'Tout sélectionner'
                  : 'Tout désélectionner',
            ),
          ...items.map((item) => _buildItem(item, context)),
        ],
      ),
    );
  }

  Widget _buildItem(T item, BuildContext context) {
    return Column(
      children: [
        canSelect
            ? AppCheckBox(
                value: selectedItems.contains(item),
                onChange: (_) => onSelect(item),
                title: item.name,
              )
            : InkWell(
                onTap: () {
                  onSelect(item);
                },
                child: Row(
                  children: [
                    Text(
                      ' ${item.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.body1.copyWith(
                        fontSize: 17.sp,
                      ),
                    ),
                    width(10),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20.sp,
                    )
                  ],
                ),
              ),
        Divider(height: 22.h)
      ],
    );
  }
}
