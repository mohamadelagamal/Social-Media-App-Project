import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/shared/components/components.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/cubit.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/states.dart';

import '../../shared/styles/icons_broken.dart';

class NewPostScreen extends StatelessWidget {


  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialLayoutCubit.get(context);
        return Scaffold(
            appBar:
                defaultAppBar(context: context, title: 'Create Post', actions: [
              defaultTextButton(function: () {
                if(!cubit.isLoadingCreatePost){
                  if(cubit.postImageUpload==null){
                    cubit.createPost(
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                    );
                  }else{
                    cubit.uploadPostImage(
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                    );
                  }
                }

              }, text: cubit.isLoadingCreatePost ? 'Loading...' : 'Post'),
              SizedBox(width: 15.0),
            ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            '${cubit.userModel!.photoUrl}'),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                        '${cubit.userModel!.name}',
                        style: TextStyle(
                          height: 1.4,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: TextFormField(

                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'What is on your mind ...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                      // make text input normal

                    ),
                  ), // text field
                  if(cubit.postImageUpload!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(cubit.postImageUpload!),
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
                              cubit.removePostImage();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                'Add Photo',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 5.0),
                              Text('#tags',
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
