class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://skyboost.me'; // À remplacer
  static const String apiBaseUrl = '$baseUrl/php';
  
  // Authentication
  static const String login = '$apiBaseUrl/connexion.php';
  static const String register = '$apiBaseUrl/inscription.php';
  static const String googleAuth = '$apiBaseUrl/google_callback.php';
  static const String logout = '$apiBaseUrl/deconnexion.php';
  
  // User
  static const String userProfile = '$baseUrl/profile.php';
  static const String userBalance = '$baseUrl/solde.php';
  static const String updateProfile = '$apiBaseUrl/update_profile.php';
  
  // Services
  static const String services = '$apiBaseUrl/services.php';
  static const String facebookServices = '$apiBaseUrl/facebook_services.php';
  static const String youtubeServices = '$apiBaseUrl/youtube_services.php';
  static const String tiktokServices = '$apiBaseUrl/tiktok_services.php';
  static const String whatsappServices = '$apiBaseUrl/whatsapp_services.php';
  
  // Orders
  static const String createOrder = '$apiBaseUrl/traitement_commande.php';
  static const String myOrders = '$apiBaseUrl/mes_commandes.php';
  static const String orderStatus = '$apiBaseUrl/order_status.php';
  
  // Transactions
  static const String transactions = '$apiBaseUrl/mes_transactions.php';
  static const String deposit = '$apiBaseUrl/depot.php';
  static const String paymentMethods = '$apiBaseUrl/payment_methods.php';
  
  // Referral
  static const String referralInfo = '$apiBaseUrl/referral_info.php';
  static const String referralHistory = '$apiBaseUrl/referral_history.php';
  
  // SMM API
  static const String smmApiUrl = 'https://smmcheep.com/api/v2';
  static const String smmApiKey = '82e7eb665080e34de6aaceb5b7cb8ad7';
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };
}