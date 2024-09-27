import 'package:app/core/di/container.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/auth/data/source/auth.cache.dart';
import 'package:app/feature/domains/data/model/domain.model.dart';
import 'package:app/feature/user/data/model/user.model.dart';
import 'package:app/feature/user/data/repo/user.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'set_domain.state.dart';

class SetDomainCubit extends Cubit<SetDomainState> {
  final _userRepo = locator<UserRepo>();

  SetDomainCubit() : super(SetDomainState.initial());

  set domain(DomainModel? domain) =>
      emit(state.__copyWith(domain: domain));

  set level(LevelModel? level) =>
      emit(state.__copyWith(domain: state.domain, level: level));

  void checkExist() async {
    final domainid = await locator<AuthCache>().domain;

    if (domainid != null) emit(state._done());

    final result = await _userRepo.getProfile();
    result.when(
      success: (user) {
        if (user.domain != null) emit(state._submitSuccess(user));
      },
      error: (_) {},
    );
  }

  void submit() async {
    if (state.domain == null || state.level == null) {
      emit(state._errorOccured(
          'Veuillez selectionner un domaine et un niveau'));
      return;
    }

    final result = await _userRepo.updateProfile(
      domainId: state.domain?.id,
      levelId: state.level?.id,
    );

    result.when(
      success: (user) => emit(state._submitSuccess(user)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }
}
