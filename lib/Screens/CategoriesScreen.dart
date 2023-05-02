import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit/layout_cubit.dart';
import '../model/categorymodel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoriesdata =
        BlocProvider.of<LayoutCubit>(context).categories;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: GridView.builder(
          itemCount: categoriesdata.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 15),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: Future.delayed(
                          Duration(seconds: 1),
                          () => categoriesdata[index].image),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return Image.network(
                            snapshot.data!,
                            fit: BoxFit.fill,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(categoriesdata[index].name)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
