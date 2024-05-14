

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
