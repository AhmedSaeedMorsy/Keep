// import 'package:dio/dio.dart';
// import 'package:zetico/app/constant/api_constant.dart';

// class DioHelper {
//   static late Dio dio;
//   static void init() {
//     dio = Dio(
//       BaseOptions(
//         receiveDataWhenStatusError: true,
//         headers: {
//           ApiConstant.authorization: ApiConstant.authorizationBody,
//         },
//       ),
//     );
//   }

//   static Future<Response> getData({
//     required String path,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     dio.options.headers = {
//       ApiConstant.authorization: ApiConstant.authorizationBody,
//     };
//     return await dio.get(
//       path,
//     );
//   }

//   static Future<Response> postData({
//     required String path,
//     Map<String, dynamic>? queryParameters,
//     dynamic data,
//   }) async {
//     dio.options.headers = {
//       ApiConstant.authorization: ApiConstant.authorizationBody,
//     };
//     return await dio.post(path, data: data);
//   }

//   static Future<Response> delData({
//     required String path,
//     Map<String, dynamic>? queryParameters,
//     dynamic data,
//   }) async {
//     dio.options.headers = {
//       ApiConstant.authorization: ApiConstant.authorizationBody,
//     };
//     return await dio.delete(
//       path,
//     );
//   }

//   static Future<Response> updateData({
//     required String path,
//     Map<String, dynamic>? queryParameters,
//     dynamic data,
//   }) async {
//     dio.options.headers = {
//       ApiConstant.authorization: ApiConstant.authorizationBody,
//     };
//     return await dio.put(path);
//   }
// }
