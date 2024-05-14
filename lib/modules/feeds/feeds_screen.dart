import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5.0,
          margin: EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image(
                image: NetworkImage(
                    'https://th.bing.com/th/id/R.292821abb1ef8ec8768033c33e22a367?rik=TM7g%2bhoxYSPWeg&riu=http%3a%2f%2ffreephotosforcommercialuse.com%2fwp-content%2fuploads%2f2015%2f10%2fFreePhotosForCommercialUse.com-free-image-free-use-4.jpg&ehk=Z7OnpyK3RuS2E0jjBs87gJG9ILqgEl1yum8laOQh2zA%3d&risl=&pid=ImgRaw&r=0'),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'communicate with friends',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => SizedBox(
              height: 10.0,
            ),
            itemCount: 10,
          ),
        SizedBox(
          height: 8.0,)

      ]),
    );
  }

  Widget buildPostItem(context)=>Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      color: Theme.of(context).cardTheme.color,

      margin: EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      'https://passportsymphony.com/wp-content/uploads/2017/12/tree-2281585_1920.jpg'
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Mohamed',
                          style: TextStyle(
                            height: 1.4,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      'October 20, 2021 at 10:00 pm',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                      ),

                    ),
                  ],
                )),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              'Hello, How are you? I hope you are doing well. I am writing this post to tell you that I am going to travel to the United States next week. I hope to see you soon.',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 14.0,
                // remove bold
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                top: 5.0,
              ),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 6.0,
                      ),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: (){},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#View Image',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 6.0,
                      ),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: (){},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#Travel',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            // set image with radius
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://th.bing.com/th/id/OIP.yM92vAHHF_FRtW4p3ffzOQHaEK?rs=1&pid=ImgDetMain',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [

                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '1200',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 16.0,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '25 Comment',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                              'https://passportsymphony.com/wp-content/uploads/2017/12/tree-2281585_1920.jpg'
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color,

                              ),
                              child: Text(
                                'write a comment...',
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: Theme.of(context).textTheme.bodyText1!.color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
  );
}
