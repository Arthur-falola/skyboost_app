import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skyboost/core/constants/api_constants.dart';
import 'package:skyboost/models/service_model.dart';

class SMMApiService {
  final String _apiUrl = ApiConstants.smmApiUrl;
  final String _apiKey = ApiConstants.smmApiKey;

  Future<List<Service>> fetchServices() async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        body: {
          'key': _apiKey,
          'action': 'services',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((item) => Service.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch services: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching services: $e');
    }
  }

  Future<List<Service>> fetchYouTubeServices() async {
    try {
      final allServices = await fetchServices();
      
      // Filter YouTube services
      return allServices.where((service) {
        final name = service.name.toLowerCase();
        return name.contains('youtube') &&
               (name.contains('views') || name.contains('like')) &&
               !name.contains('channel');
      }).toList();
    } catch (e) {
      throw Exception('Error fetching YouTube services: $e');
    }
  }

  Future<Map<String, dynamic>> placeOrder({
    required String serviceId,
    required String link,
    required int quantity,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        body: {
          'key': _apiKey,
          'action': 'add',
          'service': serviceId,
          'link': link,
          'quantity': quantity.toString(),
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to place order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error placing order: $e');
    }
  }

  Future<Map<String, dynamic>> getOrderStatus(String orderId) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        body: {
          'key': _apiKey,
          'action': 'status',
          'order': orderId,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get order status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting order status: $e');
    }
  }

  Future<double> getUserBalance() async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        body: {
          'key': _apiKey,
          'action': 'balance',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return double.tryParse(data.toString()) ?? 0.0;
      } else {
        throw Exception('Failed to get balance: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting balance: $e');
    }
  }
}