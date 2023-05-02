import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerciappbloc/localnetwork.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  //register
  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      final response = await http.post(
        Uri.parse('http://student.valuxapps.com/api/register'),
        headers: {'lang': 'en'},
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == true) {
        emit(RegisterSuccessState());
      } else {
        emit(RegisterFailedState(message: responsebody['message']));
      }
    } catch (error) {
      print(error);
    }
  }

/****************************************************************/
  void login({required String password, required String email}) async {
    emit(LoginLoadingState());
    try {
      final response = await http.post(
        Uri.parse('http://student.valuxapps.com/api/login'),
        headers: {'lang': 'en'},
        body: {'email': email, 'password': password},
      );
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['status'] == true) {
          CacheNetwork.insertToCache(key: 'token', value: responseData['data']['token']);
          emit(LoginSuccessState());
        }
      } else {
        emit(LoginFailedState(message: responseData['message']));
        print('user login Failed and reson is : ${responseData['message']}');
      }
    } catch (e) {
      print('an error occurred while trying to login $e');
      emit(LoginFailedState(message: e.toString()));
    }
  }
}
