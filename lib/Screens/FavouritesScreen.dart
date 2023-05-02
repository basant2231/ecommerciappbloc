import 'package:ecommerciappbloc/Constants/Colors.dart';
import 'package:ecommerciappbloc/cubit/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        //
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12.5,
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50))),
                )
                // i use expanded so the listview will get the rest of the screen
               , SizedBox(height: 12,)
                ,
                Expanded(
                    child: ListView.builder(
                  itemCount: cubit.favorites.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12.5),
                      color: Colors.grey.withOpacity(0.4),
                      child: Row(
                        children: [
                          Image.network(
                            cubit.favorites[index].image!,
                            height: 100,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                cubit.favorites[index].name!,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${cubit.favorites[index].price} \$',
                                style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 1,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  //add or remove
                                  cubit.addOrRemoveFromFavorites(productID: cubit.favorites[index].id.toString());
                                },
                                child: Text('Remove'),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                color: thirdColor,
                              ),
                            ],
                          ))
                        ],
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
