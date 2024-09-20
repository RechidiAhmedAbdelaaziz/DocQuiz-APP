part of 'set_domain.cubit.dart';

class SetDomainState extends ErrorState {
  final DomainModel? domain;
  final LevelModel? level;

  SetDomainState({
    this.domain,
    this.level,
    String? error,
  }) : super(error);

  factory SetDomainState.initial() {
    return SetDomainState();
  }

  SetDomainState _done() => _Done(this);

  SetDomainState _submitSuccess(UserModel user) =>
      _SubmitSuccess(this, user);

  SetDomainState _errorOccured(String error) =>
      SetDomainState(domain: domain, level: level, error: error);

  SetDomainState __copyWith({
    DomainModel? domain,
    LevelModel? level,
    String? error,
  }) {
    return SetDomainState(
      domain: domain,
      level: level,
      error: error,
    );
  }

  void onSubmitted(void Function(UserModel user) onSubmit) {
    if (this is _SubmitSuccess) {
      onSubmit((this as _SubmitSuccess).user);
    }
  }

  void onDone(void Function() onDone) {
    if (this is _Done) {
      onDone();
    }
  }
}

class _Done extends SetDomainState {
  _Done(SetDomainState state)
      : super(domain: state.domain, level: state.level);
}

class _SubmitSuccess extends SetDomainState {
  final UserModel user;
  _SubmitSuccess(SetDomainState state, this.user)
      : super(domain: state.domain, level: state.level);
}
