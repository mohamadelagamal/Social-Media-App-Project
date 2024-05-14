import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/models/user/social_user_model.dart';
import 'package:social_media_application/modules/chats/chats_screen.dart';
import 'package:social_media_application/modules/feeds/feeds_screen.dart';
import 'package:social_media_application/modules/new_post/new_post_screen.dart';
import 'package:social_media_application/modules/settings/settings_screen.dart';
import 'package:social_media_application/modules/users/users_screen.dart';
import 'package:social_media_application/shared/components/constants.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/states.dart';

import '../../../network/end_points.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutStates> {
  SocialLayoutCubit() : super(SocialLayoutInitialState());

  get favourites => null;

  static SocialLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),

  ];
  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];

  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(token)
        .get()
        .then((value) {
      // get Data from Document SnapShout
      userModel = SocialUserModel.fromMap(value.data()!);
      print(userModel);
      emit(SocialGetUserSuccessState(userModel!));
    }).catchError((error) {
      print(error);
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void changeBottomNav(int index) {
      currentIndex = index;
      emit(SocialLayoutChangeBottomNavState());
  }
}
