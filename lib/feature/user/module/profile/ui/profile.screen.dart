import 'package:app/core/extension/validator.extension.dart';
import 'package:app/core/shared/widgets/form_field.dart';
import 'package:app/core/shared/widgets/lined_text.dart';
import 'package:app/core/shared/widgets/section_box.dart';
import 'package:app/core/shared/widgets/submit_button.dart';
import 'package:app/core/theme/spaces.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/domains/logic/names.cubit.dart';
import 'package:app/feature/themes/helper/theme.extension.dart';
import 'package:app/feature/user/module/selectdomain/ui/set_domain.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/profile.cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileCubit>().state.user;

    if (user == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.teal,
      ));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          height(20),
          const _InfoForm(),
          height(45),
          const _DomainForm(),
          height(45),
          const _SecurityForm(),
          height(22),
        ],
      ),
    );
  }
}

class _InfoForm extends StatelessWidget {
  const _InfoForm();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileCubit>();
    return SectionBox(
      child: Form(
        key: cubit.infoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const LinedText('Mon Profil'),
                width(10),
                Icon(
                  Icons.person,
                  color: Colors.teal,
                  size: 30.sp,
                ),
              ],
            ),
            height(25),
            Text('Email', style: context.theme.textStyles.body1),
            height(5),
            AppInputeField(
              controller: cubit.emailController,
              hint: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value.isValidEmail,
              onChanged: cubit.infoUpdated,
            ),
            height(20),
            Text('Nom complet',
                style: context.theme.textStyles.body1),
            height(5),
            AppInputeField(
              controller: cubit.nameController,
              hint: 'Nom complet',
              keyboardType: TextInputType.name,
              validator: (value) => value.isValidString,
              onChanged: cubit.infoUpdated,
            ),
            height(30),
            SubmitButton(
              title: 'Sauvegarder',
              onPressed: cubit.updateInfo,
              enabled: cubit.canUpdateInof,
            ),
            height(8),
          ],
        ),
      ),
    );
  }
}

class _SecurityForm extends StatelessWidget {
  const _SecurityForm();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProfileCubit>();
    return SectionBox(
      child: Form(
        key: cubit.securityFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const LinedText('Sécurité'),
                width(10),
                Icon(
                  Icons.lock,
                  color: Colors.teal,
                  size: 30.sp,
                ),
              ],
            ),
            height(25),
            Text('Mot de passe',
                style: context.theme.textStyles.body1),
            height(5),
            AppInputeField(
              controller: cubit.passwordController,
              hint: 'Mot de passe',
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => value.isStrongPassword,
              onChanged: cubit.infoUpdated,
            ),
            height(20),
            Text('Nouveau mot de passe',
                style: context.theme.textStyles.body1),
            height(5),
            AppInputeField(
              controller: cubit.newPasswordController,
              hint: 'Nouveau mot de passe',
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => value.isStrongPassword,
              onChanged: cubit.infoUpdated,
            ),
            height(20),
            Text('Confirmer le mot de passe',
                style: context.theme.textStyles.body1),
            height(5),
            AppInputeField(
              controller: cubit.confirmPasswordController,
              hint: 'Confirmer le mot de passe',
              keyboardType: TextInputType.visiblePassword,
              validator: (value) =>
                  cubit.newPasswordController.text == value
                      ? null
                      : 'Les mots de passe ne correspondent pas',
              onChanged: cubit.infoUpdated,
            ),
            height(30),
            SubmitButton(
              title: 'Changer',
              onPressed: cubit.updatePassword,
              enabled: cubit.canUpdatePassword,
            ),
            height(8),
          ],
        ),
      ),
    );
  }
}

class _DomainForm extends StatelessWidget {
  const _DomainForm();

  @override
  Widget build(BuildContext context) {
    final domains =
        context.watch<NamesCubit<DomainModel, void>>().state.items;

    final levles = context
        .watch<NamesCubit<LevelModel, DomainModel>>()
        .state
        .items;

    final cubit = context.watch<ProfileCubit>();

    return SectionBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const LinedText('Specialité'),
              width(10),
              Icon(
                Icons.school,
                color: Colors.teal,
                size: 30.sp,
              ),
            ],
          ),
          height(25),
          NamesDropDown(
            title: 'Choisir votre domaine',
            items: domains,
            value: cubit.domain,
            onChanged: (value) {
              cubit.domain = value;
              cubit.level = null;
              context
                  .read<NamesCubit<LevelModel, DomainModel>>()
                  .setParent = value;
              cubit.infoUpdated('');
            },
          ),
          height(25),
          if (levles.isNotEmpty)
            NamesDropDown(
                title: 'Choisir votre niveau',
                items: levles,
                value: cubit.level,
                onChanged: (value) {
                  cubit.level = value;
                  cubit.infoUpdated('');
                }),
          height(35),
          SubmitButton(
            title: 'Sauvegarder',
            onPressed: cubit.updateSpeciality,
            enabled: cubit.canUpdateSpeciality,
          ),
          height(15),
        ],
      ),
    );
  }
}
