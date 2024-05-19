import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/modules/new_post/new_post_screen.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';
import '../modules/settings/settings_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/layout/social_layout/cubit.dart';
import '../shared/cubit/layout/social_layout/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {
        // if (state is SocialNewPostState) {
        //   navigateTo(context, NewPostScreen());
        // }
      },
      builder: (context, state) {
        var cubit = SocialLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                icon: Icon(IconBroken.Notification),
                onPressed: () {
                  //navigateTo(context, NotificationsScreen());
                },
              ),
              IconButton(
                icon: Icon(IconBroken.Search),
                onPressed: () {
                  //navigateTo(context, SearchScreen());
                },
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 10.0,
            color: Theme.of(context).cardTheme.color,
            clipBehavior: Clip.antiAlias,
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(IconBroken.Home),
                      color: cubit.currentIndex == 0 ? Colors.red : Colors.grey,
                      onPressed: () {
                        cubit.changeBottomNav(0);
                      },
                    ),
                    IconButton(
                      icon: Icon(IconBroken.Chat),
                      color: cubit.currentIndex == 1 ? Colors.red : Colors.grey,
                      onPressed: () {
                        cubit.getAllUsers();
                        cubit.changeBottomNav(1);

                      },
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    IconButton(
                      icon: Icon(IconBroken.User),
                      color: cubit.currentIndex == 2 ? Colors.red : Colors.grey,
                      onPressed: () {
                        cubit.changeBottomNav(2);
                      },
                    ),
                    IconButton(
                      icon: Icon(IconBroken.Setting),
                      color: cubit.currentIndex == 3 ? Colors.red : Colors.grey,
                      onPressed: () {
                        cubit.changeBottomNav(3);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),


          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //cubit.changeBottomNav(4);
              navigateTo(context, NewPostScreen());
            },
            child: Icon(
              IconBroken.Edit,
              color: Colors.white,
            ),
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            backgroundColor: Colors.blue,
          ),
        );
      },
    );
  }
}

// verification email
// ConditionalBuilder(
// condition: cubit.userModel != null,
// builder: (context) {
//
// return  Column(
// children: [
// // verify your email
// if(!FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// color: Colors.amber.withOpacity(0.6),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 20.0,
//
// ),
// child: Row(
// children: [
// Icon(Icons.info_outline),
// SizedBox(
// width: 15.0,
// ),
// Expanded(
// child: Text(
// 'Please verify your email',
// style: TextStyle(
// fontSize: 16.0,
// ),
// ),
// ),
//
// TextButton(onPressed:() {
// // send email verification
// FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
// showToast(
// text: 'Check your email',
// state: ToastStates.SUCCESS,
// );
// }).catchError((error) {
// showToast(
// text: 'Please check your mailbox.',
// state: ToastStates.ERROR,
// );
// });
// }, child:
// Text('Send'))
// ],
// ),
// ),
// ),
//
//
// ],
// );
// },
// fallback: (context) => Center(
// child: Center(child: CircularProgressIndicator()),
// ),
// )
