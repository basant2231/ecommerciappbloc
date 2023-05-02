import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import 'package:ecommerciappbloc/Constants/Colors.dart';

import 'HomeScreen.dart';
import 'LayoutScreen.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/images/auth_background.png"),
                  fit: BoxFit.fill)),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginLoadingState) {
                //////////
              } else if (state is LoginFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(alignment: Alignment.center,height: 50,
                  child: Text(state.message),
                )));
                ///////////
              } else if (state is LoginSuccessState) {
                Navigator.pop(context); // عشان يخرج من alertDialog
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: 40),
                      child: const Text(
                        "Login to continue process",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      decoration: BoxDecoration(
                          color: thirdColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: "Email",
                              ),
                              validator: (input) {
                                if (emailController.text.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Email must not be empty";
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Password",
                              ),
                              validator: (input) {
                                if (passwordController.text.isNotEmpty) {
                                  return null;
                                } else {
                                  return "Password must not be empty";
                                }
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            MaterialButton(
                              height: 40,
                              elevation: 0,
                              onPressed: () {
                                if (formKey.currentState!.validate() == true) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              minWidth: double.infinity,
                              color: mainColor,
                              textColor: Colors.white,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    state is LoginLoadingState
                                        ? "Loading..."
                                        : "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.5),
                                  )),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Do not have an acount',
                                    style: TextStyle(color: Colors.black)),
                                SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: const Text('Create one',
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
