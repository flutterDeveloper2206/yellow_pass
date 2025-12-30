import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

import '../core/utils/common_function.dart';
import '../core/utils/progress_dialog_utils.dart';
import 'network_info.dart';
import '../core/utils/shared_prefs.dart';
import '../routes/app_routes.dart';
import '../widgets/common_snackbar.dart';

class ApiService extends GetConnect {
  ApiService() {
    timeout = const Duration(seconds: 120);
  }
  var headers;
  var headersWithToken;
  var contentType;
  String authToken = '';

  Future<void> getToken() async {}

  Future<void> initApiService() async  {
    await NetworkInfo.checkNetwork().whenComplete(() async {
      authToken = SharedPrefs.getToken() ?? '';
      // print("Auth Token from API service is :- $authToken");
      headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
      };
      headersWithToken = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $authToken"
      };
      contentType = "application/json";
    });
  }

  Future<dynamic> callPostApi(
      {required body,
      required url,
      bool showLoader = true,
      bool headerWithToken = true}) async {

    if(isLogPrint) {
      log("API :- $url");
    }

    if (showLoader) {
      ProgressDialogUtils.showProgressDialog(isCancellable: false);
    }
    
    try {
      await initApiService();
      final response = await post(
        url,
        body,
        headers: headerWithToken ? headersWithToken : headers,
        contentType: contentType,
      );
      
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }

      if(isLogPrint) {
        log("RESPONSE :- ${response.body}");
      }
      
      if (response.status.hasError) {
        _handleError(response);
        return null;
      } else {
        if (_checkUnauthenticated(response.body)) {
          return null;
        }
        return response.body;
      }
    } catch (e) {
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      log("Exception: $e");
      CommonSnackbar.showError(message: "An unexpected error occurred: $e");
      return null;
    }
  }

  Future<dynamic> callGetApi(
      {
      required url,
      bool showLoader = true,
      bool headerWithToken = true}) async {

    if(isLogPrint) {
      log("API :- $url");
      log("API :- ${isLogPrint.toString()}");
    }

    if (showLoader) {
      ProgressDialogUtils.showProgressDialog(isCancellable: false);
    }
    
    try {
      await initApiService();

      final response = await get(
        url,
        headers: headerWithToken ? headersWithToken : headers,
        contentType: contentType,
      );
      
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }

      if(isLogPrint) {
        log("RESPONSE :- ${response.body}");
      }

       if (response.status.hasError) {
        _handleError(response);
        return null;
      } else {
        if (_checkUnauthenticated(response.body)) {
          return null;
        }
        return response.body;
      }
    } catch (e) {
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      log("Exception: $e");
      CommonSnackbar.showError(message: "An unexpected error occurred: $e");
      return null;
    }
  }

  Future<FormData> getBlankApiBody() async {
    final form = FormData({});
    return form;
  }

  Future<dynamic> callPutApi(
      {required body,
      required url,
      bool showLoader = true,
      bool headerWithToken = true}) async {

    if(isLogPrint) {
      log("API :- $url");
    }

    if (showLoader) {
      ProgressDialogUtils.showProgressDialog(isCancellable: false);
    }

    try {
      await initApiService();
      final response = await put(
        url,
        body,
        headers: headerWithToken ? headersWithToken : headers,
        contentType: contentType,
      );

      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }

      if(isLogPrint) {
        log("RESPONSE :- ${response.body}");
      }

      if (response.status.hasError) {
        _handleError(response);
        return null;
      } else {
        if (_checkUnauthenticated(response.body)) {
          return null;
        }
        return response.body;
      }
    } catch (e) {
      if (showLoader) {
        ProgressDialogUtils.hideProgressDialog();
      }
      log("Exception: $e");
      CommonSnackbar.showError(message: "An unexpected error occurred: $e");
      return null;
    }
  }
  

  void _handleError(Response response) {
    String message = "Unknown error occurred";
    String title = "Error";
    
    try {
      if (response.body is Map && response.body['message'] != null) {
        message = response.body['message'];
      } else if (response.statusText != null) {
        message = response.statusText!;
      }
    } catch (e) {
      message = "Error processing response";
    }
    
    switch (response.statusCode) {
      case 400:
        title = "Bad Request";
        break;
      case 401:
        title = "Session Expired";
        message = "Unauthorized. Please login again.";
        SharedPrefs.removeToken(); 
        Get.offAllNamed(AppRoutes.loginScreenRoute); 
        break;
      case 403:
        title = "Forbidden";
        break;
      case 404:
        title = "Not Found";
        break;
      case 500:
        title = "Server Error";
        message = "Internal Server Error. Please try again later.";
        break;
      case 503:
        title = "Service Unavailable";
        break;
      default:
        title = "Error ${response.statusCode}";
    }
    
    CommonSnackbar.showError(message: message, title: title);
  }

  bool _checkUnauthenticated(dynamic body) {
    if (body is Map && body['status_code'] == 401) {
      SharedPrefs.removeToken();
      Get.offAllNamed(AppRoutes.loginScreenRoute);
      return true;
    }
    return false;
  }
}
