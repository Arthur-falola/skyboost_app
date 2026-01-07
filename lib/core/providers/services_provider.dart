import 'package:flutter/material.dart';
import 'package:skyboost/core/services/smm_api_service.dart';
import 'package:skyboost/models/service_model.dart';

class ServicesProvider with ChangeNotifier {
  final SMMApiService _apiService = SMMApiService();
  
  List<Service> _youtubeServices = [];
  List<Service> _facebookServices = [];
  List<Service> _tiktokServices = [];
  List<Service> _whatsappServices = [];
  double _userBalance = 0.0;
  bool _isLoading = false;
  String? _error;

  List<Service> get youtubeServices => _youtubeServices;
  List<Service> get facebookServices => _facebookServices;
  List<Service> get tiktokServices => _tiktokServices;
  List<Service> get whatsappServices => _whatsappServices;
  double get userBalance => _userBalance;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchYouTubeServices() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _youtubeServices = await _apiService.fetchYouTubeServices();
      _userBalance = await _apiService.getUserBalance();
      _error = null;
    } catch (e) {
      _error = 'Erreur lors du chargement des services YouTube: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFacebookServices() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final allServices = await _apiService.fetchServices();
      
      _facebookServices = allServices.where((service) {
        final name = service.name.toLowerCase();
        return name.contains('facebook');
      }).toList();
      
      _userBalance = await _apiService.getUserBalance();
      _error = null;
    } catch (e) {
      _error = 'Erreur lors du chargement des services Facebook: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> placeOrder({
    required String serviceId,
    required String link,
    required int quantity,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _apiService.placeOrder(
        serviceId: serviceId,
        link: link,
        quantity: quantity,
      );
      
      // Update balance after order
      _userBalance = await _apiService.getUserBalance();
      
      _isLoading = false;
      _error = null;
      notifyListeners();
      
      return result;
    } catch (e) {
      _error = 'Erreur lors de la commande: $e';
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> refreshBalance() async {
    try {
      _userBalance = await _apiService.getUserBalance();
      notifyListeners();
    } catch (e) {
      _error = 'Erreur lors du rafraîchissement du solde: $e';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}