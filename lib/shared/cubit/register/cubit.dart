import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/models/login/login_model.dart';
import 'package:social_media_application/models/user/social_user_model.dart';
import 'package:social_media_application/modules/login/login_screen.dart';
import 'package:social_media_application/shared/components/constants.dart';
import 'package:social_media_application/shared/cubit/login/states.dart';
import 'package:social_media_application/shared/cubit/register/states.dart';
import 'package:social_media_application/shared/network/end_points.dart';
import 'package:social_media_application/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  SocialLoginModel? registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid,
          photoUrl:
              'https://e1.pxfuel.com/desktop-wallpaper/244/477/desktop-wallpaper-49-best-walls-of-jihad-high-quality-jihad-fisabilillah.jpg',
          bio: 'write you bio...',
          coverPhoto:
              'https://th.bing.com/th/id/OIP.yM92vAHHF_FRtW4p3ffzOQHaEK?rs=1&pid=ImgDetMain',
          isEmailVerified: false);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

  void userCreate(
      {required String email,
      required String name,
      required String phone,
      required String uId,
      required String photoUrl,
      required String bio,
      required String coverPhoto,
      required bool isEmailVerified}) {
    emit(SocialRegisterLoadingState());
    SocialUserModel model = SocialUserModel(
        id: uId,
        name: name,
        email: email,
        photoUrl: photoUrl,
        phone: phone,
        bio: bio,
        cover: coverPhoto,
        isEmailVerified: isEmailVerified);
    // user fireStore
    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      // update token
      token = uId;
      emit(SocialCreateUserSuccessState(model));
      print('User added to Firestore');
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
      print('Error adding user to Firestore: $error');
    });
  }
}
