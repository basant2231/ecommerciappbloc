import 'package:ecommerciappbloc/model/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Constants/Colors.dart';
import '../cubit/cubit/layout_cubit.dart';

class HomeScreen extends StatelessWidget {
  final pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    // Don't forget to use BlocConsumer to access the BlocProvider
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: cubit.banners.isEmpty
                    // use a ternary operator to check if the banners list is empty
                    ? [Center(child: CupertinoActivityIndicator())]
                    : [
                        TextFormField(
                          onChanged: (input) {
                            cubit.filteredproducts(input: input);
                          },
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(Icons.clear),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          height: 125,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: pagecontroller,
                            physics: BouncingScrollPhysics(),
                            itemCount: 3,
                            //the numbers of items that will be displayed next to each others
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Image.network(
                                  cubit.banners[index].url!,
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: pagecontroller,
                            count: 3,
                            axisDirection: Axis.horizontal,
                            effect: SlideEffect(
                                spacing: 8.0,
                                radius: 25.0,
                                dotWidth: 16.0,
                                dotHeight: 16.0,
                                paintStyle: PaintingStyle.stroke,
                                strokeWidth: 1.5,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.grey[800]!),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'View All',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        /********************************************** */
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: cubit.categories.isEmpty
                              // use a ternary operator to check if the banners list is empty
                              ? [Center(child: CupertinoActivityIndicator())]
                              : [
                                  SizedBox(height: 15),
                                  SizedBox(
                                    height: 125,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: cubit.categories.length,
                                      //the numbers of items that will be displayed next to each others
                                      itemBuilder: (context, index) {
                                        return CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage(
                                              cubit.categories[index].image,
                                            ));
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(width: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Products',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'View All',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  cubit.products.isEmpty
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: cubit
                                                  .filterproductsList.isEmpty
                                              ? cubit.products.length
                                              : cubit.filterproductsList.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 0.6,
                                            crossAxisSpacing: 12,
                                          ),
                                          itemBuilder: (context, index) {
                                            return ProductItem(cubit: cubit,
                                              model: cubit.filterproductsList
                                                      .isEmpty
                                                  ? cubit.products[index]
                                                  : cubit.filterproductsList[
                                                      index],
                                            );
                                          },
                                        ),
                                ],
                        ),
                      ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget ProductItem({required ProductModdel model,required LayoutCubit cubit}) => Stack(alignment: Alignment.bottomCenter,
    children: [
      Container(
            color: Colors.grey.withOpacity(0.2),
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 12),
            child: Column(
              children: [
                Expanded(child: Image.network(model.image!)),
                Text(
                  model.name!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                ),
                Row( 
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${model.price!}\$',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '${model.oldPrice!}\$',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.favorite,
                        size: 20,
                        color: cubit.favoritesID.contains(model.id.toString())?Colors.red:Colors.grey,
                      ),
                      onTap: () {
         cubit.addOrRemoveFromFavorites(productID: model.id.toString());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          CircleAvatar(backgroundColor: Colors.black.withOpacity(0.3),child: GestureDetector(onTap: (){
            cubit.addorremoveProductFromCard(id: model.id.toString());
          },child: Icon(Icons.shopping_cart,color: cubit.cartsId.contains(model.id.toString())?Colors.red:Colors.white,),),)
    ],
  );
}
