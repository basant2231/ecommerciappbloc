import 'package:ecommerciappbloc/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cubit/cubit/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
       final cubit= BlocProvider.of<LayoutCubit>(context);
        return Scaffold(appBar: AppBar(elevation: 0,backgroundColor: thirdColor,title: SvgPicture.asset('lib/images/logo.svg',height: 40,width: 40,color: mainColor,),),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bottomnavindex,
            selectedItemColor:mainColor ,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              cubit.changebottomnavindex(index: index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),body: cubit.layoutScreen[cubit.bottomnavindex],
        );
      },
    );
  }
}
