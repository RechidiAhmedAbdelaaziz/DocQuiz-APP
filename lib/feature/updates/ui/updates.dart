import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/themes/spaces.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:app/feature/updates/logic/updtes.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Updates extends StatelessWidget {
  const Updates({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class NotificationBox extends StatelessWidget {
  const NotificationBox({super.key});

  @override
  Widget build(BuildContext context) {
    final updates = context.watch<UpdatesCubit>().state.updates;
    return SafeArea(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: AppBar().preferredSize.height + 4.h,
              // horizontal: 35.w,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 20.w,
            ),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: context.colors.dark.withOpacity(0.4),
                  blurRadius: 10.r,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    width(10),
                    Text(
                      'MISES À JOUR',
                      style: context.textStyles.h3,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        color: context.colors.dark,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                updates.isEmpty
                    ? Text(
                        'Il n\'y a pas de mises à jour pour le moment.',
                        style: context.textStyles.body2,
                      )
                    : Column(
                        children: updates.map((update) {
                          return SectionBox(
                            margin:
                                EdgeInsets.symmetric(vertical: 10.h),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    update.title,
                                    style: context.textStyles.h1
                                        .copyWith(color: Colors.teal),
                                  ),
                                  height(12),
                                  Text(
                                    update.description,
                                    style: context.textStyles.h5,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
