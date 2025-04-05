part of 'subscription_form_cubit.dart';

enum _SubscriptionFormStatus {
  initial,
  loading,
  loaded,
  error,
}

class SubscriptionFormState extends CubitErrorState {
  final CreateSubscriptionDto _dto;
  final _SubscriptionFormStatus _status;

  const SubscriptionFormState({
    required CreateSubscriptionDto dto,
    _SubscriptionFormStatus status = _SubscriptionFormStatus.initial,
    String? errorMessage,
  })  : _dto = dto,
        _status = status,
        super(errorMessage);

  factory SubscriptionFormState.initial() => SubscriptionFormState(
        dto: CreateSubscriptionDto(),
      );

  bool get isLoading => _status == _SubscriptionFormStatus.loading;

  SubscriptionFormState _copyWith({
    CreateSubscriptionDto? dto,
    _SubscriptionFormStatus? status,
    String? errorMessage,
  }) {
    return SubscriptionFormState(
      dto: dto ?? _dto,
      status: status ?? _status,
      errorMessage: errorMessage,
    );
  }

  SubscriptionFormState _loading() => _copyWith(
        status: _SubscriptionFormStatus.loading,
      );

  SubscriptionFormState _loaded(SubscriptionModel model) => _Saved(
        model,
        dto: _dto,
      );

  SubscriptionFormState _error(String errorMessage) => _copyWith(
        status: _SubscriptionFormStatus.error,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [_dto, _status];

  void onSave(void Function(SubscriptionModel model) onSaved) {}
}

class _Saved extends SubscriptionFormState {
  final SubscriptionModel _model;

  const _Saved(
    this._model, {
    required super.dto,
  }) : super(
          status: _SubscriptionFormStatus.loaded,
        );

  @override
  void onSave(void Function(SubscriptionModel model) onSaved) =>
      onSaved(_model);
}
