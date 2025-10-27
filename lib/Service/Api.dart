import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  // ✅ Constants (moved here from AppConstants)
  static const String _baseUrl = 'http://192.168.29.223:3002/api/auth'; // <-- Change this!
  static const String _tokenKey = 'authToken';

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {
      'Content-Type': 'application/json',
      // 'Access-Control-Allow-Origin': '*',
    },
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 15),
  ));

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Initializes Dio interceptors (e.g., adds auth headers)
  static void init() {
    _dio.interceptors.clear();

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException error, handler) {
        if (error.response?.statusCode == 401) {
          print('Unauthorized - handle logout or redirect here');
        }
        handler.next(error);
      },
    ));
  }

  /// Save token securely
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Get saved token
   static Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      print("SecureStorage read error: $e");

      // Clear all secure storage if corrupted
      await clearSecureStorage();
      return null;
    }
  }

static Future<void> clearSecureStorage() async {
   return await _storage.deleteAll();
}

  /// Remove saved token (logout)
  static Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// Make a GET request
 static Future<Response> get(String endpoint,
    {Map<String, dynamic>? query}) async {
  final token = await getToken();
  print("➡️ GET Request:");
  print("URL: ${_dio.options.baseUrl}$endpoint");
  print("Headers: ${token != null ? {'Authorization': 'Bearer $token'} : {}}");
  if (query != null) print("Query: $query");

  try {
    final response = await _dio.get(endpoint, queryParameters: query);
    print("✅ Response: ${response.data}");
    return response;
  } catch (e) {
    print("❌ GET Error: $e");
    rethrow;
  }
}


  /// Make a POST request
  static Future<Response> post(
      String endpoint, Map<String, dynamic> data) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      print('Dio POST error: ${e}- ${e.response?.statusCode} - ${e.message}');
      throw e; // let caller catch it
    }
  }
}
