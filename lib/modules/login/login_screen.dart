import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_application/layout/social_layout.dart';
import 'package:social_media_application/modules/basics/conditional_builder.dart';
import 'package:social_media_application/modules/register/register_screen.dart';
import 'package:social_media_application/shared/components/components.dart';
import 'package:social_media_application/shared/cubit/login/cubit.dart';
import 'package:social_media_application/shared/cubit/login/states.dart';
import 'package:social_media_application/shared/network/local/cache_helper.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false; // add this line

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text:'Please check the data ', state: ToastStates.ERROR);
          }
          if (state is SocialLoginSuccessState) {
           CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
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
                          Text('LOGIN',
                              style: Theme.of(context).textTheme.headline4),
                          SizedBox(height: 10),
                          Text('Login now to browse our hot offers',
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: 50),
                          defaultTextField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              } else {
                                return null; // return null when the TextField's value is not empty
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email,
                            context: context,
                            submit: (String value) {
                              // remove validation error
                            },
                            change: (String value) {
                              formKey.currentState!.validate();
                            },
                          ),
                          SizedBox(height: 15),
                          defaultTextField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
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
                                  SocialLoginCubit.get(context).isPassword,
                              context: context,
                              suffixPressed: () {
                                isPasswordVisible = !isPasswordVisible;
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              change: (String value) {
                                formKey.currentState!.validate();
                              },
                              submit: (String value) {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          SizedBox(height: 30),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            trueBuilder: (context) => Container(
                              width: double.infinity,
                              color: Colors.deepOrange,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Text('LOGIN',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            falseBuilder: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  // move to Social register screen
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                child: Text('REGISTER NOW'),
                              ),
                            ],
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
