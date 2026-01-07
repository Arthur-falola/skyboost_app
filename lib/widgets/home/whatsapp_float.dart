import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skyboost/core/constants/colors.dart';

class WhatsAppFloat extends StatefulWidget {
  const WhatsAppFloat({super.key});

  @override
  State<WhatsAppFloat> createState() => _WhatsAppFloatState();
}

class _WhatsAppFloatState extends State<WhatsAppFloat>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _hasNotification = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _openWhatsApp() async {
    const phoneNumber = '22943644303';
    const message = 'Bonjour, je suis intéressé par les services SkyBoost';
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
    
    // Clear notification after opening
    setState(() {
      _hasNotification = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: _openWhatsApp,
        child: Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.whatsapp,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.whatsapp.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              if (_hasNotification)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}