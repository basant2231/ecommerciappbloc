import 'package:ecommerciappbloc/Screens/LoginScreen.dart';
import 'package:ecommerciappbloc/cubit/auth_cubit.dart';
import 'package:ecommerciappbloc/localnetwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constants/Constants.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/LayoutScreen.dart';
import 'Screens/profileScreen.dart';
import 'cubit/cubit/layout_cubit.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
await CacheNetwork.cacheInitialization();
//doesnt let the code run untill everything is ok 
token =CacheNetwork.getcacheDate(key:'token' );
print('token is $token');
  runApp(
    const MyApp(),
  );
}
/* in the route if there is a value go to homescreen if there is not go to the login*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
     
        ),
        BlocProvider<LayoutCubit>(
          //approximatly every get methode i have to call it up here cascade operator
          create: (_) => LayoutCubit()..getBannerData()..getCategoryData()..getProductsData()..getFavorites()..getCarts( ),
     
        ),
        // Add more BlocProviders if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:token != null && token!=''? const LayoutScreen() : LoginScreen(),
      ),
    );
  }
}
// as long as i am using multiblocprovider dont user bloc provider in every screen only bloc consumer