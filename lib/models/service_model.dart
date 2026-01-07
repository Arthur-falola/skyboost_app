class Service {
  final String id;
  final String name;
  final String category;
  final String type;
  final double rate;
  final int min;
  final int max;
  final String description;
  final int refill;
  final int cancel;
  
  Service({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.rate,
    required this.min,
    required this.max,
    required this.description,
    required this.refill,
    required this.cancel,
  });
  
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['service'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      rate: double.tryParse(json['rate'].toString()) ?? 0.0,
      min: int.tryParse(json['min'].toString()) ?? 0,
      max: int.tryParse(json['max'].toString()) ?? 0,
      description: json['description'] ?? '',
      refill: json['refill'] ?? 0,
      cancel: json['cancel'] ?? 0,
    );
  }
  
  double calculatePrice(int quantity) {
    return (quantity * rate * 600 / 1000);
  }
}

class SocialNetwork {
  final String id;
  final String name;
  final String icon;
  final Color color;
  final String route;
  
  const SocialNetwork({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.route,
  });
  
  static List<SocialNetwork> get allNetworks => [
    SocialNetwork(
      id: 'facebook',
      name: 'Facebook',
      icon: 'assets/icons/facebook.svg',
      color: AppColors.facebook,
      route: '/services/facebook',
    ),
    SocialNetwork(
      id: 'youtube',
      name: 'YouTube',
      icon: 'assets/icons/youtube.svg',
      color: AppColors.youtube,
      route: '/services/youtube',
    ),
    SocialNetwork(
      id: 'tiktok',
      name: 'TikTok',
      icon: 'assets/icons/tiktok.svg',
      color: AppColors.tiktok,
      route: '/services/tiktok',
    ),
    SocialNetwork(
      id: 'whatsapp',
      name: 'WhatsApp',
      icon: 'assets/icons/whatsapp.svg',
      color: AppColors.whatsapp,
      route: '/services/whatsapp',
    ),
  ];
}