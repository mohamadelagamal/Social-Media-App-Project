
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/models/login/login_model.dart';
import 'package:social_media_application/shared/components/constants.dart';
import 'package:social_media_application/shared/cubit/login/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  SocialLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => {
      token= value.user!.uid,
      emit(SocialLoginSuccessState(value.user!.uid)),
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));

    });
  }

  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(SocialLoginChangePasswordVisibilityState());
  }
}