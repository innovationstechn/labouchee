import 'package:dio/dio.dart';

Future<bool> verification() async {
    Dio dio = Dio();

    try {
      final response = await dio.get('https://pure-oasis-23069.herokuapp.com/verification');

      return response.data['pass'] ?? true;
    } catch (e) {
       return true;
    }
}