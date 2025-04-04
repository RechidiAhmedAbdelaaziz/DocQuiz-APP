import 'package:app/core/extension/alertdialog.extenstion.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/notes/logic/note.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notes extends StatelessWidget {
  const Notes({super.key, required this.questionId});

  final String questionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(questionId)..fetchNote(),
      child: const _Notes(),
    );
  }
}

class _Notes extends StatelessWidget {
  const _Notes();

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NoteCubit>().state.note?.notes ?? [];
    return Column(
      children: [
        InkWell(
          onTap: () {
            final controller = TextEditingController();
            context.showPopUp(
                content: Stack(
              alignment: Alignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 350.w,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w, vertical: 22.h),
                    decoration: BoxDecoration(
                      color: context.colors.background,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: context.colors.dark.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.dark.withOpacity(0.3),
                          blurRadius: 7.r,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  Ajouter une note',
                          style: context.textStyles.h4,
                        ),
                        height(10),
                        AppInputeField(
                          controller: controller,
                          keyboardType: TextInputType.multiline,
                        ),
                        height(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<NoteCubit>().addNotes(
                                      controller.text,
                                    );
                                context.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colors.dark,
                                foregroundColor:
                                    context.colors.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(20.r),
                                ),
                                textStyle: context.textStyles.body1,
                              ),
                              child: const Text('Ajouter'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
          },
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.teal,
            child: const Icon(Icons.add),
          ),
        ),
        height(8),
        Expanded(
            child: SingleChildScrollView(
              child: Column(
                        children: [
              if (notes.isEmpty)
                Center(
                  child: Text(
                    'Aucune note n\'a été ajoutée',
                    style: context.textStyles.h4,
                  ),
                ),
              if (notes.isNotEmpty)
                ...notes.map((note) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: context.colors.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note.note!, style: context.textStyles.h5),
                        height(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: const Icon(Icons.edit,
                                  color: Colors.teal),
                              onTap: () {
                                final controller =
                                    TextEditingController(
                                        text: note.note);
                                controller.text = note.note!;
                                context.showPopUp(
                                    content: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        width: 350.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w,
                                            vertical: 22.h),
                                        decoration: BoxDecoration(
                                          color:
                                              context.colors.background,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  20.r),
                                          border: Border.all(
                                            color: context.colors.dark
                                                .withOpacity(0.3),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: context.colors.dark
                                                  .withOpacity(0.3),
                                              blurRadius: 7.r,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize:
                                              MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '  Modifier la note',
                                              style:
                                                  context.textStyles.h4,
                                            ),
                                            height(10),
                                            AppInputeField(
                                              controller: controller,
                                              keyboardType:
                                                  TextInputType
                                                      .multiline,
                                            ),
                                            height(10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            NoteCubit>()
                                                        .updateNotes(
                                                          note.index!,
                                                          controller
                                                              .text,
                                                        );
                                                    context.back();
                                                  },
                                                  style: ElevatedButton
                                                      .styleFrom(
                                                    backgroundColor:
                                                        context.colors
                                                            .dark,
                                                    foregroundColor:
                                                        context.colors
                                                            .background,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  20.r),
                                                    ),
                                                    textStyle: context
                                                        .textStyles
                                                        .body1,
                                                  ),
                                                  child: const Text(
                                                      'Modifier'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                              },
                            ),
                            width(15),
                            InkWell(
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                context.showDialogBox(
                                  title: 'Supprimer',
                                  body:
                                      'Voulez-vous vraiment supprimer cette note?',
                                  confirmText: 'Supprimer',
                                  onConfirm: (back) {
                                    context
                                        .read<NoteCubit>()
                                        .deleteNotes(note.index!);
                                    back();
                                  },
                                  cancelText: 'Annuler',
                                  onCancel: (back) => back(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                        ],
                      ),
            )),
        height(22),
      ],
    );
  }
}
