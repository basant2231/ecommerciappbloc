import 'package:ecommerciappbloc/Constants/Colors.dart';
import 'package:ecommerciappbloc/cubit/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerciappbloc/Constants/Colors.dart';
import 'package:ecommerciappbloc/cubit/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.5,
                ),
                Expanded(
                  child: cubit.carts.isEmpty
                      ? Center(
                          child: Text('Loading........'),
                        )
                      : ListView.separated(
                          itemCount: cubit.carts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(color: thirdColor),
                              child: Container(
                                child: Row(
                                  children: [
                                    Image.network(
                                      cubit.carts[index].image!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            cubit.carts[index].name!,
                                            style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  cubit.addOrRemoveFromFavorites(
                                                    productID: cubit.carts[index].id.toString(),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: cubit.favoritesID.contains(
                                                    cubit.carts[index].id.toString(),
                                                  )
                                                      ? Colors.grey
                                                      : Colors.red,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cubit.addorremoveProductFromCard(
                                                    id: cubit.carts[index].id.toString(),
                                                  );
                                                },
                                                child: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 12.5,
                            );
                          },
                        ),
                ),
                Container(
                  child: Text(
                    'TotalPrice: ${cubit.totalprice}\$',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


 /* cubit.carts[index].price !=
                                                    cubit.carts[index].oldPrice
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${cubit.carts[index].oldPrice}',
                                                        style: TextStyle(
                                                            decoration: TextDecoration
                                                                .lineThrough,),
                                                      ),
                                                      Text(
                                                          '${cubit.carts[index].price!} \$'),
                                                    ],
                                                  )
                                                : Text(
                                                    '${cubit.carts[index].price!} \$'),
                                                    SizedBox(height: 5,)*/
