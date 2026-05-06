import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/dio_factory.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => DioFactory.getDio();
}