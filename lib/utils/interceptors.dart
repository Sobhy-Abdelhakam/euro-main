import 'package:dio/dio.dart';
import 'package:euro/utils/log_utils.dart';

///Header management interceptor
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Accept"] = "application/json";
    super.onRequest(options, handler);
  }
}

///Log interceptor settings
class LoggingInterceptor extends Interceptor {
  DateTime? startTime;
  DateTime? endTime;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    startTime = DateTime.now();
    Log.d("----------Request Start---------");
    Log.i(" path :${options.path}");

    // if(options.path.contains(Api.getCountriesListApiCall)){
    //   options.baseUrl=Api.nartaqiBaseUrl;
    // }

    ///print full path request
    if (options.queryParameters.isEmpty) {
      if (options.path.contains(options.baseUrl)) {
        Log.i("RequestUrl:${options.path}");
      } else {
        Log.i("RequestUrl:${options.baseUrl}${options.path}");
      }
    } else {
      ///If queryParameters is not empty, splice into a complete URl
      Log.i(
          "RequestUrl:${options.baseUrl}${options.path}?${Transformer
              .urlEncodeMap(options.queryParameters)}");
    }

    Log.w("RequestMethod:${options.method}");
    Log.w("RequestHeaders:${options.headers}");
    Log.w("RequestContentType:${options.contentType}");

    if (options.data is FormData) {
      Log.w(
          "RequestDataFormDataOptions:${(options.data as FormData).fields
              .toString()}");
      Log.w(
          "RequestDataFormDataFiles:${(options.data as FormData).files
              .asMap()
              .values}");
    } else {
      Log.w("RequestDataOptions:${options.data.toString()}");
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    endTime = DateTime.now();
    //Request duration
    int duration = endTime!.difference(startTime!).inMilliseconds;
    Log.i("----------End Request $duration millisecond---------");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e("--------------Error-----------");
    Log.e('${err.toString()} ∞ ${err.message}');
    super.onError(err, handler);
  }
}


//parsing data
class AdapterInterceptor extends Interceptor {
  static const String defaultError = "\"NOT_FOUND\"";
  static const String notFoundError = "Some Thing Wrong Happened";

  static const String failureFormat = "{\"code\":%d,\"message\":\"%s\"}";
  static const String successFormat =
      "{\"code\":0,\"data\":%s,\"message\":\"\"}";

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    Response mResponse = adapterData(response);
    return super.onResponse(mResponse, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      adapterData(err.response!);
    }
    return super.onError(err, handler);
  }

  Response adapterData(Response response) {
    String result;
    String content = response.data == null ? "" : response.data.toString();
    if (response.statusCode == 200) {
      if (content.isEmpty) {
        content = defaultError;
      }
      result = Log.i('$successFormat $content');
      response.statusCode = 200;
    } else {
      result = Log.e('$failureFormat ${response.statusCode} $notFoundError');
      response.statusCode = 200;
    }
    if (response.statusCode == 200) {
      Log.d("ResponseCode:${response.statusCode}");
      Log.d("response:${response.data}");
    } else {
      Log.e("ResponseCode:${response.statusCode}");
      Log.d("response:${response.data}");
    }
    Log.json(result);
    response.data = result;
    return response;
  }
}
