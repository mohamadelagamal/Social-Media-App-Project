import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_application/shared/components/components.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/cubit.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/states.dart';

import '../../shared/styles/icons_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  dynamic profileImageEditScreen;
  dynamic coverImageEditScreen;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialLayoutCubit.get(context);
        var userModel = cubit.userModel;
        // set data to text field
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        // profile image
        var profileImage = cubit.profileImage;
        var coverImage= cubit.coverImage;

        if (profileImage == null) {
          profileImageEditScreen = NetworkImage('${userModel!.photoUrl}');
        } else {
          profileImageEditScreen = FileImage(profileImage);
        }
        if (coverImage == null) {
          coverImageEditScreen = NetworkImage('${userModel!.cover}');
        } else {
          coverImageEditScreen = FileImage(coverImage);
        }

        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'New Post', actions: [
            defaultTextButton(
              function: () {
                if (!cubit.isLoading) {
                  cubit.updateUserModel(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                }
              },
              text: cubit.isLoading ? 'Loading...' : 'Update',
            ),
            SizedBox(width: 15.0),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialLayoutUpdateLoadingProfileDataState)
                  LinearProgressIndicator(),
                  Container(
                    height: 190.0,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImageEditScreen,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.blue,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.getCoverImage();
                                      },
                                      icon: Icon(
                                        IconBroken.Camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImageEditScreen,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  //edit name
                  defaultTextField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                      change: (String value) {
                        formKey.currentState!.validate();
                      },
                      context: context),
                  SizedBox(height: 15.0),
                  // edit bio
                  defaultTextField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your bio';
                        }
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      maxLines: null,
                      change: (String value) {
                        formKey.currentState!.validate();
                      },
                      context: context),
                  SizedBox(height: 15.0),
                  // edit bio
                  defaultTextField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                      change: (String value) {
                        formKey.currentState!.validate();
                      },
                      context: context),
              
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
