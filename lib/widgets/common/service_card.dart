import 'package:flutter/material.dart';
import 'package:skyboost/core/constants/colors.dart';
import 'package:skyboost/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final SocialNetwork network;
  final VoidCallback onTap;
  
  const ServiceCard({
    super.key,
    required this.network,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: _getGradient(network.id),
              ),
              child: Icon(
                _getIcon(network.id),
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              network.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _getDescription(network.id),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.rocket_launch,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Commencer',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _getGradient(String networkId) {
    switch (networkId) {
      case 'facebook':
        return AppColors.facebookGradient;
      case 'youtube':
        return AppColors.youtubeGradient;
      case 'tiktok':
        return AppColors.tiktokGradient;
      case 'whatsapp':
        return AppColors.whatsappGradient;
      default:
        return AppColors.primaryGradient;
    }
  }

  IconData _getIcon(String networkId) {
    switch (networkId) {
      case 'facebook':
        return Icons.facebook;
      case 'youtube':
        return Icons.play_circle_fill;
      case 'tiktok':
        return Icons.music_note;
      case 'whatsapp':
        return Icons.chat;
      default:
        return Icons.language;
    }
  }

  String _getDescription(String networkId) {
    switch (networkId) {
      case 'facebook':
        return 'Boost Facebook\nLikes & Followers';
      case 'youtube':
        return 'Vues & Abonnés\nYouTube';
      case 'tiktok':
        return 'Boost TikTok\nVues & Followers';
      case 'whatsapp':
        return 'Audience\nWhatsApp';
      default:
        return 'Service réseau social';
    }
  }
}