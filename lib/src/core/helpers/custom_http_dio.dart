import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/auth_model.dart';

class CustomHttpDio implements CustomHttp {
  String? get token => Modular.get<AuthModel>().token;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
    ),
  )..interceptors.addAll(
      [
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          requestBody: true,
          responseBody: true,
          request: false,
        ),
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers['Content-Type'] = 'application/json';
            options.headers['authorization'] = Modular.get<AuthModel>().token;
            handler.next(options);
          },
          onError: (DioError e, handler) {
            log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
            log(e.response.toString());
            handler.next(e);
          },
        )
      ],
    );

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on CustomException catch (_) {
      rethrow;
    } on DioError catch (e) {
      _verify401(e.response, e.requestOptions);
      throw CustomException(
        error: e.response,
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e, s) {
      throw CustomException(error: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on CustomException catch (_) {
      rethrow;
    } on DioError catch (e) {
      _verify401(e.response, e.requestOptions);
      throw CustomException(
        error: e.response,
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e, s) {
      throw CustomException(error: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on CustomException catch (_) {
      rethrow;
    } on DioError catch (e) {
      _verify401(e.response, e.requestOptions);
      throw CustomException(
        error: e.response,
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e, s) {
      throw CustomException(error: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on CustomException catch (_) {
      rethrow;
    } on DioError catch (e) {
      _verify401(e.response, e.requestOptions);
      throw CustomException(
        error: e.response,
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e, s) {
      throw CustomException(error: e.toString(), stackTrace: s);
    }
  }

  void _verify401(Response? response, RequestOptions requestOptions) {
    if (response?.statusCode == 401 && !requestOptions.path.contains('login')) {
      // TODO:Implementar aviso de erro
      Modular.to.navigate('/');
      Modular.get<AuthModel>().clear();
    }
  }
}
