part of 'profile.cubit.dart';

class ProfileState extends ErrorState {
  final UserModel? user;

  ProfileState({
    this.user,
    String? error,
  }) : super(error);

  factory ProfileState.initial() => ProfileState();

  ProfileState _fetchProfile(UserModel user) => _copyWith(user: user);

  ProfileState _updateProfile(UserModel? user) =>
      _UpdateProfile(user ?? this.user!);

  ProfileState _errorOccured(String error) =>
      ProfileState(user: user, error: error);

  ProfileState _copyWith({
    UserModel? user,
    String? error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      error: error,
    );
  }

  void onUpdated(void Function(String message) onUpdated) {
    if (this is _UpdateProfile) {
      onUpdated('Votre profil a été mis à jour');
    }
  }
}

class _UpdateProfile extends ProfileState {
  _UpdateProfile(UserModel user) : super(user: user);
}
