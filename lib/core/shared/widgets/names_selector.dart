import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/widgets/check_box.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NamesSelector<T extends NamedModel> extends StatelessWidget {
  NamesSelector({
    super.key,
    this.controller,
    required this.items,
    required this.onSelect,
    this.highlitedItem,
    this.canSelect = true,
    this.selectedItems,
    this.onSelectAll,
  })  : canSelectAll = onSelectAll != null,
        selectedAll = selectedItems?.containsAll(items) ?? false;

  final List<T> items;
  final List<T>? selectedItems;
  final T? highlitedItem;
  final ValueChanged<T> onSelect;
  final ValueChanged<bool>? onSelectAll;
  final bool canSelectAll;
  final bool canSelect;
  final bool selectedAll;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          if (canSelectAll) ...[
            AppCheckBox(
              value: selectedAll,
              onChange: (_) => onSelectAll!(selectedAll),
              title: !selectedAll
                  ? 'Tout sélectionner'
                  : 'Tout désélectionner',
            ),
            height(25),
          ],
          ...items.map((item) => _buildItem(item, context)),
        ],
      ),
    );
  }

  Widget _buildItem(T item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: highlitedItem == item
            ? context.theme.colors.dark.withOpacity(0.1)
            : null,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          canSelect
              ? AppCheckBox(
                  value: selectedItems?.contains(item),
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
        ],
      ),
    );
  }
}
