import 'package:flutter/material.dart';
import 'package:skyboost/core/constants/colors.dart';
import 'package:skyboost/models/service_model.dart';

class FacebookServicesScreen extends StatelessWidget {
  const FacebookServicesScreen({super.key});

  final List<Map<String, dynamic>> services = const [
    {
      'id': 'fblpu',
      'title': 'Mentions J\'aime de publication',
      'description': 'Boostez vos posts avec des likes authentiques',
      'icon': Icons.thumb_up,
      'route': '/services/order/fblpu',
    },
    {
      'id': 'fblpa',
      'title': 'Mentions J\'aime de page',
      'description': 'Augmentez l\'engagement de votre page',
      'icon': Icons.favorite,
      'route': '/services/order/fblpa',
    },
    {
      'id': 'fbrp',
      'title': 'Réactions pour publication',
      'description': '♥️ 😳 😡 👍 😃 Diversifiez vos réactions',
      'icon': Icons.emoji_emotions,
      'route': '/services/order/fbrp',
    },
    {
      'id': 'fbfo',
      'title': 'Abonnés Facebook',
      'description': 'Développez votre communauté',
      'icon': Icons.people,
      'route': '/services/order/fbfo',
    },
    {
      'id': 'fbvv',
      'title': 'Vues de vidéos',
      'description': 'Boostez la visibilité de vos vidéos',
      'icon': Icons.play_circle_fill,
      'route': '/services/order/fbvv',
    },
    {
      'id': 'fbpa',
      'title': 'Partages de publications',
      'description': 'Augmentez la portée de vos posts',
      'icon': Icons.share,
      'route': '/services/order/fbpa',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 480 ? 
            (MediaQuery.of(context).size.width - 480) / 2 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: MediaQuery.of(context).size.width > 480 ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SkyBoost',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Services Facebook',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.facebook,
                              color: AppColors.facebook,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Services Facebook',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        Column(
                          children: services.map((service) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    service['route'],
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.centerLeft,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.facebook.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        service['icon'],
                                        color: AppColors.facebook,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            service['title'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            service['description'],
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: AppColors.secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}