import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerciappbloc/Constants/Constants.dart';
import 'package:ecommerciappbloc/Screens/CartScreenScreen.dart';
import 'package:ecommerciappbloc/Screens/CategoriesScreen.dart';
import 'package:ecommerciappbloc/Screens/HomeScreen.dart';
import 'package:ecommerciappbloc/Screens/profileScreen.dart';
import 'package:ecommerciappbloc/model/bannermode.dart';
import 'package:flutter/material.dart';

import '../../Screens/FavouritesScreen.dart';
import '../../model/ProductModel.dart';
import '../../model/categorymodel.dart';
import '../../model/usermodel.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  Usermodel? usermodel;
  int bottomnavindex = 0;
  void changebottomnavindex({required int index}) {
    bottomnavindex = index;
    emit(ChangeBottomNavIndexState());
  }

//observe the order throught the arrangement i a will get the index
  List<Widget> layoutScreen = [
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  /******************************************************************** */
  void getUserData() async {
    Dio _dio = Dio();

    try {
      Response response =
          await _dio.get('https://student.valuxapps.com/api/profile',
              options: Options(
                headers: {
                  'Authorization': token!,
                  'lang': 'en',
                },
              ));
      var responsedata = response.data;

      if (responsedata['status'] == true) {
        usermodel = Usermodel.fromjson(data: responsedata['data']);
        print(responsedata);
        emit(SuccessGetUserDataState());
      } else {
        print(responsedata);
        emit(FailedGetUserDataState(error: responsedata['message']));
      }
    } catch (e) {
      emit(FailedGetUserDataState(
          error: 'An error occurred while fetching user data.'));
      print(e.toString());
    }
  }

  /******************************************************************************* */
  List<BannerModel> banners = [];
  void getBannerData() async {
    final url = 'https://student.valuxapps.com/api/banners';
    Response response = await Dio().get(url,
        options: Options(
          headers: {
            'Authorization': token!,
            'lang': 'en',
          },
        ));
    final responsedata = response.data;
    if (responsedata['status'] == true) {
      for (var item in responsedata['data']) {
        banners.add(BannerModel.fromJson(data: item));
      }
      emit(GetBannerSuccessState());
    } else {
      emit(GetBannerFailingState());
    }
  }

  /******************************************************************************* */
  List<CategoryModel> categories = [];
  void getCategoryData() async {
    final url = 'https://student.valuxapps.com/api/categories';
    Response response = await Dio().get(url,
        options: Options(
          headers: {
            'Authorization': token!,
            'lang': 'en',
          },
        ));
    final responsedata = response.data;
    if (responsedata['status'] == true) {
      for (var item in responsedata['data']['data']) {
        categories.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategorySuccessState());
    } else {
      emit(GetCategoryFailingState());
    }
  }

/****************************************************************************** */
  List<ProductModdel> products = [];

  void getProductsData() async {
    final url = 'https://student.valuxapps.com/api/home';
    final response = await Dio().get(url,
        options: Options(
          headers: {
            'Authorization': token!,
            'lang': 'en',
          },
        ));
    final responsedata = response.data;

    if (responsedata['status'] == true) {
      for (var item in responsedata['data']['products']) {
        products.add(ProductModdel.fromJson(data: item));
      }
      emit(GetProductsSuccessState());
    } else {
      emit(GetProductsFailingState());
    }
  }

  /**************************************************************************/
  List<ProductModdel> filterproductsList = [];

  void filteredproducts({required String input}) {
    filterproductsList = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilteredProductSuccessState());
  }

/*************************************************************************** */
// Initialize an empty list of favorite products and an empty set of favorite product IDs
  List<ProductModdel> favorites = [];
  Set<String> favoritesID = {};

// Define an asynchronous function to get the user's favorite products from the API
  Future<void> getFavorites() async {
    // Clear the list of favorite products before fetching new data
    favorites.clear();

    try {
      // Send a GET request to the favorites endpoint of the API, including the user's token in the headers
      final response = await Dio().get(
        'https://student.valuxapps.com/api/favorites',
        options: Options(headers: {
          'lang': 'en',
          'Authorization': token!,
        }),
      );

      // If the API returns a successful response, iterate through the data to extract the favorite products
      if (response.data['status'] == true) {
        for (var item in response.data['data']['data']) {
          favorites.add(ProductModdel.fromJson(data: item['product']));
          favoritesID.add(item['product']['id'].toString());
        }

        // Log the number of favorite products and emit a successful state
        print("Favorites number is : ${favorites.length}");
        emit(getFavouritesSuccessState());
      } else {
        // If the API returns an error response, emit a failed state
        emit(getFavouritesFailedState());
      }
    } catch (e) {
      // If an exception is thrown, log the error and emit a failed state
      print('Error: $e');
      emit(getFavouritesFailedState());
    }
  }

/******************************************************************************/

// Define a synchronous function to add or remove a product from the user's favorites
  void addOrRemoveFromFavorites({required String productID}) async {
    try {
      // Send a POST request to the favorites endpoint of the API with the product ID, including the user's token in the headers
      final response = await Dio().post(
        'https://student.valuxapps.com/api/favorites',
        data: {
          'product_id': productID,
        },
        options: Options(headers: {
          'lang': 'en',
          'Authorization': token!,
        }),
      );

      // If the API returns a successful response, update the list of favorite products and emit a successful state
      if (response.data['status'] == true) {
        if (favoritesID.contains(productID) == true) {
          favoritesID.remove(productID);
        } else {
          favoritesID.add(productID);
        }
        await getFavorites();
        emit(SuccessAddorRemoveItemFromFavouriteState());
      } else {
        // If the API returns an error response, emit a failed state
        emit(FailedAddorRemoveItemFromFavouriteState());
      }
    } catch (e) {
      // If an exception is thrown, log the error and emit a failed state
      print('Error: $e');
      emit(FailedAddorRemoveItemFromFavouriteState());
    }
  }

/*************************************************************************** */
//take care my dear sister is it get or post or what ya kamar in the postman
  
List<ProductModdel>carts=[];
Set<String>cartsId={};//1
int totalprice=0;
 Future<void> getCarts() async {
  carts.clear();
  cartsId.clear();

  try {
    final response = await Dio().get(
      'https://student.valuxapps.com/api/carts',
      options: Options(
        headers: {
          'lang': 'en',
          'Authorization': token!,
        },
      ),
    );

    if (response.data['status'] == true) {
      for (var item in response.data['data']['cart_items']) {
        carts.add(ProductModdel.fromJson(data: item['product']));
       cartsId.add(item['product']['id'].toString());
      }
      totalprice = response.data['data']['total'].toInt(); 


      print('Carts length is ${carts.length}');
      emit(GetCartsSuccessState());
    } else {
      emit(GetCartsFailedState());
    }
  } catch (e) {
    print('Error: $e');
    emit(GetCartsFailedState());
  }
}


/*************************************************************************** */
//implementation the id if it exist delete it if it isnot existing delete
//in the body i should send the id through body
  void addorremoveProductFromCard({required String id}) async {
    final response = await Dio().post(
      //make sure about this details like the response from the api
      'https://student.valuxapps.com/api/carts',
      data: {'product_id': id},
      options: Options(headers: {
        'Authorization': token,
        'lang': 'en',
      }),
    );
    final Responsedata = response.data;
    if (Responsedata['status'] == true) {

//To call it to update the data
      await getCarts();
      cartsId.contains(id)==true?cartsId.remove(id):cartsId.add(id);
      emit(AddToCardSuccessState());
    } else {
      emit(AddToCardFailingState());
    }
  }
}

/*************************************************************************** */
/*************************************************************************** */
/*************************************************************************** */
/*************************************************************************** */
/*************************************************************************** */
/*************************************************************************** */

//add remove product from card i want body id

// i want to get data from the values and assign it to the variables in the class
// iam refactoring the only partial thing here
//difference between const and final
/*if there is response like that {
            "id": 26,
            "image": "https://student.valuxapps.com/storage/uploads/banners/1680055176jJA1U.Gold Black White Elegant Minimalist Christmas Thanksgiving Food Month Banner.png",
            "category": null,
            "product": null
        },
        {
            "id": 27,
            "image": "https://student.valuxapps.com/storage/uploads/banners/1680054520Ku9S1.food Banner Landscape.png",
            "category": {
                "id": 42,
                "image": "https://student.valuxapps.com/storage/uploads/categories/16445270619najK.6242655.jpg",
                "name": "رياضة"
            },
            "product": null
        } i have to loop
*/

//wrap column with expanded instead of flexible