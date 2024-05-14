import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_application/layout/social_layout.dart';
import 'package:social_media_application/shared/cubit/register/cubit.dart';
import 'package:social_media_application/shared/cubit/register/states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../basics/conditional_builder.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  bool isPasswordVisible = false; // add this line

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          // if state error
          if (state is SocialRegisterErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialCreateUserSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.userModel.id).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          // update token
          var cubit = SocialRegisterCubit.get(context);
          // update token
         // token = cubit.registerModel!.data!.token!;
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',
                              style: Theme.of(context).textTheme.headline4),
                          SizedBox(height: 10),
                          Text('Register now to browse our hot offers',
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: 50),
                          defaultTextField(
                              controller: nameController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                              },
                              label: 'Name',
                              prefix: Icons.person,
                              change: (String value) {
                                formKey.currentState!.validate();
                              },
                              context: context),
                          SizedBox(height: 15),
                          defaultTextField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email,
                              change: (String value) {
                                formKey.currentState!.validate();
                              },
                              context: context),
                          SizedBox(height: 15),
                          defaultTextField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              change: (String value) {
                                formKey.currentState!.validate();
                              },
                              suffix: isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock,
                              isPassword:
                              SocialRegisterCubit.get(context).isPassword,
                              context: context,
                              suffixPressed: () {
                                isPasswordVisible = !isPasswordVisible;
                                SocialRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              submit: (String value) {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                          // Add phone number field
                          SizedBox(height: 15),
                          defaultTextField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                              },
                              label: 'Phone Number',
                              prefix: Icons.phone,
                              change: (String value) {
                                formKey.currentState!.validate();
                              },
                              context: context),
                          SizedBox(height: 30),
                          ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            trueBuilder: (context) => Container(
                              width: double.infinity,
                              color: Colors.deepOrange,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                child: Text('REGISTER',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            falseBuilder: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
