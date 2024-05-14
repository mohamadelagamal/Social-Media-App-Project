abstract class SocialLoginStates {}
// initial state
class SocialLoginInitialState extends SocialLoginStates {}
// loading
class SocialLoginLoadingState extends SocialLoginStates {}
// success
class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;
  SocialLoginSuccessState(this.uId);
}
// error
class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}
//password visibility
class SocialLoginChangePasswordVisibilityState extends SocialLoginStates {}
//password visibility
