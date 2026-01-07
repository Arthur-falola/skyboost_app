import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF7800);
  static const Color primaryDark = Color(0xFFFF8C00);
  static const Color secondary = Color(0xFF6C757D);
  static const Color success = Color(0xFF28A745);
  static const Color error = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color facebook = Color(0xFF1877F2);
  static const Color youtube = Color(0xFFFF0000);
  static const Color tiktok = Color(0xFFFF0050);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color dark = Color(0xFF212529);
  static const Color light = Color(0xFFF8F9FA);
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient facebookGradient = LinearGradient(
    colors: [Color(0xFF1877F2), Color(0xFF4267B2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient youtubeGradient = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFFCC0000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient tiktokGradient = LinearGradient(
    colors: [Color(0xFFFF0050), Color(0xFF00F2EA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient whatsappGradient = LinearGradient(
    colors: [Color(0xFF25D366), Color(0xFF128C7E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}