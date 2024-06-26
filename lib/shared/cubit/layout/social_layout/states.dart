

import 'package:social_media_application/models/user/social_user_model.dart';

abstract class SocialLayoutStates {}

class SocialLayoutInitialState extends SocialLayoutStates {}

class SocialLayoutChangeBottomNavState extends SocialLayoutStates {}
// state for post new
class SocialNewPostState extends SocialLayoutStates {}
// state for settings
class SocialSettingsState extends SocialLayoutStates {}

class SocialLayoutChangeIndexState extends SocialLayoutStates {}

// get data from API Home data
// 1- loading
class SocialLayoutLoadingHomeDataState extends SocialLayoutStates {}
// 2- success
class SocialLayoutSuccessHomeDataState extends SocialLayoutStates {}
// 3- error
class SocialLayoutErrorHomeDataState extends SocialLayoutStates {}

// get data from API Categories data
// 1- loading
class SocialLayoutLoadingCategoriesDataState extends SocialLayoutStates {}
// 2- success
class SocialLayoutSuccessCategoriesDataState extends SocialLayoutStates {}
// 3- error
class SocialLayoutErrorCategoriesDataState extends SocialLayoutStates {}

// get data from API Favourites data
// 1- loading
class SocialLayoutLoadingFavouritesDataState extends SocialLayoutStates {

}
// 2- success
class SocialLayoutSuccessFavouritesDataState extends SocialLayoutStates {}
// 3- error
class SocialLayoutErrorFavouritesDataState extends SocialLayoutStates {}

// get data from API Favorites data
// 1- loading
class SocialLayoutGetLoadingFavoritesDataState extends SocialLayoutStates {}
// 2- success
class SocialLayoutGetSuccessFavoritesDataState extends SocialLayoutStates {}
// 3- error
class SocialLayoutGetErrorFavoritesDataState extends SocialLayoutStates {}

// get data from API Profile data
// 1- loading
class SocialLayoutLoadingProfileDataState extends SocialLayoutStates {}
// 2- success
class SocialLayoutSuccessProfileDataState extends SocialLayoutStates {

}
// 3- error
class SocialLayoutErrorProfileDataState extends SocialLayoutStates {}

// update data from API Profile data
// 1- loading
class SocialLayoutUpdateLoadingProfileDataState extends SocialLayoutStates {}
// 2- success
class SocialLayoutUpdateSuccessProfileDataState extends SocialLayoutStates {

}
// 3- error
class SocialLayoutUpdateErrorProfileDataState extends SocialLayoutStates {}

// check if internet connection is available
class SocialLayoutCheckInternetConnectionState extends SocialLayoutStates {}

// user
class SocialGetUserLoadingState extends SocialLayoutStates {}
class SocialGetUserSuccessState extends SocialLayoutStates {
  final SocialUserModel userModel;
  SocialGetUserSuccessState(this.userModel);
}
class SocialGetUserErrorState extends SocialLayoutStates {
  final String error;
  SocialGetUserErrorState(this.error);
}
// profile image state
class SocialProfileImagePickedSuccessState extends SocialLayoutStates {}
class SocialProfileImagePickedErrorState extends SocialLayoutStates {}

// cover image state
class SocialCoverImagePickedSuccessState extends SocialLayoutStates {}
class SocialCoverImagePickedErrorState extends SocialLayoutStates {}

// upload image state
class SocialUploadProfileImageSuccessState extends SocialLayoutStates {}
class SocialUploadProfileImageErrorState extends SocialLayoutStates {}

// Create Post State
class SocialCreatePostLoadingState extends SocialLayoutStates {}
class SocialCreatePostSuccessState extends SocialLayoutStates {}
class SocialCreatePostErrorState extends SocialLayoutStates {}
// get Posts State picker
class SocialPostImagePickedSuccessState extends SocialLayoutStates {}
class SocialPostImagePickedErrorState extends SocialLayoutStates {}
//remove Post Image State
class SocialRemovePostImageState extends SocialLayoutStates {}

// get Posts user State
class SocialGetPostsUserLoadingState extends SocialLayoutStates {}
class SocialGetPostsUserSuccessState extends SocialLayoutStates {}
class SocialGetPostsUserErrorState extends SocialLayoutStates {}

// create like posts
class SocialCreateLikePostsSuccessState extends SocialLayoutStates {}
class SocialCreateLikePostsErrorState extends SocialLayoutStates {
  final String error;
  SocialCreateLikePostsErrorState(this.error);
}
// get All users
class SocialGetAllUsersLoadingState extends SocialLayoutStates {}
class SocialGetAllUsersSuccessState extends SocialLayoutStates {}
class SocialGetAllUsersErrorState extends SocialLayoutStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

// message state
class SocialSendMessageSuccessState extends SocialLayoutStates {}
class SocialSendMessageErrorState extends SocialLayoutStates {
  final String error;
  SocialSendMessageErrorState(this.error);
}
class SocialGetMessagesLoadingState extends SocialLayoutStates {}
class SocialGetMessagesSuccessState extends SocialLayoutStates {}
class SocialGetMessagesErrorState extends SocialLayoutStates {
  final String error;
  SocialGetMessagesErrorState(this.error);
}
