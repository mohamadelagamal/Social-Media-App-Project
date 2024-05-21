import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_application/models/message/message_model.dart';
import 'package:social_media_application/models/post/post_model.dart';
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
  String? profileImageEditScreen;
  String? coverImageEditScreen;

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

  // get Profile Image from Gallery
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // update
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  // get Cover Image from Gallery
  File? coverImage;
  var pickerCover = ImagePicker();
  Future<void> getCoverImage() async {
    final pickedFile = await pickerCover.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // update
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  // upload profile image to Firebase Storage
  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateProfileImage(value);
        profileImageEditScreen = value;
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // upload cover image to Firebase Storage
  void uploadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateCoverImage(value);
        coverImageEditScreen = value;
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // update profile image
  bool isLoading = false; // Add this line at the top of your class

  void updateUserModel({
    required String name,
    required String phone,
    required String bio,
  }) {
    isLoading = true;
    emit(SocialLayoutUpdateLoadingProfileDataState());

    if (coverImage != null && profileImage != null) {
      uploadCoverImage();
      uploadProfileImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null) {
      // uploadProfileImage();
      uploadCoverImage();
    } else {
      SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        email: userModel!.email,
        bio: bio,
        cover: coverImageEditScreen ?? userModel!.cover,
        photoUrl: profileImageEditScreen ?? userModel!.photoUrl,
        id: userModel!.id,
        isEmailVerified: userModel!.isEmailVerified,
      );
      FirebaseFirestore.instance
          .collection(USER_COLLECTION)
          .doc(userModel!.id)
          .update(model.toMap())
          .then((value) {
        getUserData();
        isLoading = false;
        emit(SocialLayoutUpdateSuccessProfileDataState());
      }).catchError((error) {
        isLoading = false;
        emit(SocialLayoutUpdateErrorProfileDataState());
      });
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(userModel!.id)
        .update({'photoUrl': imageUrl}).then((value) {
      print('Profile Image Updated');
      getUserData();
      isLoading = false;
      emit(SocialLayoutUpdateSuccessProfileDataState());
    }).catchError((error) {
      print(error);
      isLoading = false;
      emit(SocialLayoutUpdateErrorProfileDataState());
    });
  }

  Future<void> updateCoverImage(String imageUrl) async {
    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(userModel!.id)
        .update({'cover': imageUrl}).then((value) {
      print('Cover Image Updated');
      getUserData();
      isLoading = false;
      emit(SocialLayoutUpdateSuccessProfileDataState());
    }).catchError((error) {
      print(error);
      isLoading = false;
      emit(SocialLayoutUpdateErrorProfileDataState());
    });
  }

  // create new post
  // get Post Image from Gallery
  bool isLoadingCreatePost = false; // Add this line at the top of your class

  File? postImageUpload;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // update
      postImageUpload = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }
  // remove post image
  void removePostImage() {
    postImageUpload = null;
    emit(SocialRemovePostImageState());
  }
  Future<void> uploadPostImage({
    required String text,
    required String dateTime,
  }) async {
    isLoadingCreatePost = true;
    emit(SocialCreatePostLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImageUpload!.path).pathSegments.last}')
        .putFile(postImageUpload!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImageUpload: value,
        );
        // coverImageEditScreen = value;
        emit(SocialCreatePostSuccessState());
        isLoadingCreatePost = false;
      }).catchError((error) {
        isLoadingCreatePost = false;
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      isLoadingCreatePost = false;
      emit(SocialCreatePostErrorState());
    });
  }

  Future<void> createPost({
    required String text,
    required String dateTime,
    String postImageUpload = '',
  }) async {
     isLoadingCreatePost = true;
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      id: userModel!.id,
      name: userModel!.name,
      photoUrl: userModel!.photoUrl,
      dateTime: dateTime,
      text: text,
      postImage: postImageUpload.toString(),
    );
    // upload to FireStore
    FirebaseFirestore.instance
        .collection(POST_COLLECTION)
        .add(model.toMap())
        .then((value) {
      isLoadingCreatePost = false;
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      isLoadingCreatePost = false;
      emit(SocialCreatePostErrorState());
    });
  }


  // get posts
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<bool> isLikes = [];

  void getPosts() {
    emit(SocialGetPostsUserLoadingState());
    posts = [];
    postsId = [];
    likes = [];
    comments = [];
    isLikes = [];
    FirebaseFirestore.instance.collection(POST_COLLECTION).get().then((value) {
      value.docs.forEach((element) {

        element.reference.collection(LIKES_COLLECTION).get().then((value){

          posts.add(PostModel.fromMap(element.data()));
          postsId.add(element.id);
          likes.add(value.docs.length);
          comments.add(element.data()['comments']);
          isLikes.add(false);
        }).catchError((onError){

        });

      });
      emit(SocialGetPostsUserSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsUserErrorState());
    });
  }

  // create like posts
  void likePosts(String postId){
    FirebaseFirestore.instance.collection(POST_COLLECTION).doc(postId).collection(LIKES_COLLECTION).doc(
      userModel!.id
    ).set({
      'like': true,
    }).then((value) {
      emit(SocialCreateLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialCreateLikePostsErrorState(error.toString()));
    });

  }
  // create comments posts
  void createComment(String comment){
    FirebaseFirestore.instance.collection(POST_COLLECTION).doc(comment).collection(COMMENT_COLLECTION).doc(
        userModel!.id
    ).set({
      'comment': comment,
    }).then((value) {
      emit(SocialCreateLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialCreateLikePostsErrorState(error.toString()));
    });

  }

  // get all users
  List<SocialUserModel> users = [];
  void getAllUsers(){
    emit(SocialGetUserLoadingState());
    users = [];
    FirebaseFirestore.instance.collection(USER_COLLECTION).get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['id'] != userModel!.id)
        users.add(SocialUserModel.fromMap(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  // message
  void sendMessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel!.id,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    // upload to FireStore
    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(userModel!.id)
        .collection(CHATS_COLLECTION)
        .doc(receiverId)
        .collection(MESSAGES_COLLECTION)
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    // receiver
    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(receiverId)
        .collection(CHATS_COLLECTION)
        .doc(userModel!.id)
        .collection(MESSAGES_COLLECTION)
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }
  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    emit(SocialGetMessagesLoadingState());
    messages = [];
    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(userModel!.id)
        .collection(CHATS_COLLECTION)
        .doc(receiverId)
        .collection(MESSAGES_COLLECTION)
        .orderBy(DATE_COLLECTION)
        .snapshots() // get data as stream of data
        .listen((event) {

      messages = [];// clear list before add new data to it
      // get data from snapshot and add it to list
      event.docs.forEach((element) {
        // add data to list
        messages.add(MessageModel.fromMap(element.data()));
        print(element.data());
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}
