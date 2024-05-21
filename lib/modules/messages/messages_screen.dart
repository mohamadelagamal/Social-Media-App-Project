import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/models/message/message_model.dart';
import 'package:social_media_application/models/user/social_user_model.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

import '../../shared/cubit/layout/social_layout/cubit.dart';
import '../../shared/cubit/layout/social_layout/states.dart';

class MessagesScreen extends StatelessWidget {
  var textController = TextEditingController();
  SocialUserModel userModel;
  MessagesScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialLayoutCubit.get(context).getMessages(receiverId: userModel.id);

      return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${userModel.photoUrl}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text('${userModel.name}'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        // make sender message on the right side and receiver message on the left side and sort messages from sender and receiver by data make message item for each one
                        if (cubit.messages[index].senderId == userModel.id && index%2==0) {
                          return buildMessageItemReceiver(cubit.messages[index]);
                        }
                        return buildMessageItemSender(cubit.messages[index]);

                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.0,
                      ),
                      itemCount: cubit.messages.length,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'type your message here ...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            cubit.sendMessage(
                              receiverId: userModel.id,
                              dateTime: DateTime.now().toString(),
                              text: textController.text,
                            );
                            textController.text = '';
                          },
                          minWidth: 1.0,
                          child: Icon(
                            IconBroken.Send,
                            size: 16.0,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildMessageItemReceiver(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            '${message.text}',
          ),
          // dateTime: DateTime.now().toString(),
        ),
      );
  Widget buildMessageItemSender(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            '${message.text}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
}
