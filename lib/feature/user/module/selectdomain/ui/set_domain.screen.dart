import 'package:app/core/di/container.dart';
import 'package:app/core/extension/navigator.extension.dart';
import 'package:app/core/extension/snackbar.extension.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/auth/data/source/auth.cache.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/logic/names.cubit.dart';
import 'package:app/feature/home/helper/home.route.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:app/feature/user/module/selectdomain/logic/set_domain.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetDomainScreen extends StatelessWidget {
  const SetDomainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SetDomainCubit>();

    final domains =
        context.watch<NamesCubit<DomainModel, void>>().state.items;

    final levles = context
        .watch<NamesCubit<LevelModel, DomainModel>>()
        .state
        .items;

    return BlocListener<SetDomainCubit, SetDomainState>(
      listener: (context, state) {
        void goHome() => context.off(HomeRoute(), canPop: false);

        state.onError((error) => context.showErrorSnackBar(error));
        state.onSubmitted((user) async {
          await locator<AuthCache>().setDomain(user.domain!.id);
          goHome();
        });
        state.onDone(goHome);
      },
      child: Scaffold(
        body: Center(
          child: SectionBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                height(15),
                NamesDropDown(
                  title: 'Choisir votre domaine',
                  items: domains,
                  value: cubit.state.domain,
                  onChanged: (value) {
                    cubit.domain = value;
                    context
                        .read<NamesCubit<LevelModel, DomainModel>>()
                        .setParent = value;
                  },
                ),
                height(25),
                if (levles.isNotEmpty)
                  NamesDropDown(
                    title: 'Choisir votre niveau',
                    items: levles,
                    value: cubit.state.level,
                    onChanged: (value) => cubit.level = value,
                  ),
                height(35),
                SubmitButton(
                  title: 'Sauvegarder',
                  onPressed: () async => cubit.submit(),
                ),
                height(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NamesDropDown<T extends NamedModel> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Function(T?) onChanged;
  final Icon? icon;
  final T? value;

  const NamesDropDown({
    super.key,
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
          style: context.textStyles.h5,
        ),
        height(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.colors.dark.withOpacity(0.4),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              icon ?? const SizedBox(),
              width(12),
              Expanded(
                child: DropdownButton<T>(
                  iconEnabledColor: context.colors.dark,
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                    value?.name ?? 'Select',
                    style: context.textStyles.h5.copyWith(
                      color: value?.name == null
                          ? context.colors.dark.withOpacity(0.5)
                          : context.colors.dark,
                    ),
                  ),
                  items: items
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name),
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
