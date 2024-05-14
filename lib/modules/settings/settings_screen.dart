import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/shared/components/components.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/cubit.dart';
import 'package:social_media_application/shared/cubit/layout/social_layout/states.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(listener: (context,state){

    },builder: (context,state){
      var cubit = SocialLayoutCubit.get(context).userModel;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 190.0,
              child:
              Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 140.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${cubit!.cover}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 65.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        '${cubit!.photoUrl}'),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text('${cubit!.name}',
                style: TextStyle(
                  color: Colors.white,
                  //make text bold
                  fontWeight: FontWeight.bold,
                )),
            // set bio
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0
              ),
              child: Text(
                '${cubit!.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Theme.of(context).textTheme.bodyText2!.color,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20.0
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('Posts',
                              style: TextStyle(
                                color: Colors.white,
                                //make text bold
                                fontWeight: FontWeight.bold,
                              )),
                          // set bio
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('photos',
                              style: TextStyle(
                                color: Colors.white,
                                //make text bold
                                fontWeight: FontWeight.bold,
                              )),
                          // set bio
                          Text(
                            '25',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('Followers',
                              style: TextStyle(
                                color: Colors.white,
                                //make text bold
                                fontWeight: FontWeight.bold,
                              )),
                          // set bio
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('Friends',
                              style: TextStyle(
                                color: Colors.white,
                                //make text bold
                                fontWeight: FontWeight.bold,
                              )),
                          // set bio
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        'Add Photo',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    child: Icon(
                      IconBroken.Edit,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
