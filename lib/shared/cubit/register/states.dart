

import 'package:social_media_application/models/login/login_model.dart';
import 'package:social_media_application/models/user/social_user_model.dart';

abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}
// loading
class SocialRegisterLoadingState extends SocialRegisterStates {}
// success
class SocialRegisterSuccessState extends SocialRegisterStates {

  final SocialUserModel registerModel;
  SocialRegisterSuccessState(this.registerModel);
}
// error
class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}
//password visibility
class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {}

// user states

class SocialCreateUserSuccessState extends SocialRegisterLoadingState {
  final SocialUserModel userModel;
  SocialCreateUserSuccessState(this.userModel);
}
class SocialCreateUserLoadingState extends SocialRegisterLoadingState{

}
class SocialCreateUserErrorState extends SocialRegisterLoadingState{
  final String error;
  SocialCreateUserErrorState(this.error);
}
