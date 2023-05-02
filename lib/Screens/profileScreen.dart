import 'package:ecommerciappbloc/cubit/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getUserData(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          if (state is FailedGetUserDataState) {
            // Handle the error state here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<LayoutCubit>(context);

          if (state is SuccessGetUserDataState) {
            return Scaffold(
              
               
              
              body: Column(
                children: [
                  Text(cubit.usermodel!.name!),
                  SizedBox(height: 10,),
                  Text(cubit.usermodel!.email!),
                ],
              ),
            );
          } else {
            return Scaffold(
              
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
