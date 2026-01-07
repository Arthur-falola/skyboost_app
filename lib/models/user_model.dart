class User {
  final int id;
  final String username;
  final String email;
  final double balance;
  final String? avatar;
  final String? referralCode;
  final int referralCount;
  final DateTime createdAt;
  final String currency;
  
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.balance,
    this.avatar,
    this.referralCode,
    required this.referralCount,
    required this.createdAt,
    this.currency = 'XOF',
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      balance: (json['balance'] ?? 0.0).toDouble(),
      avatar: json['avatar'],
      referralCode: json['referral_code'],
      referralCount: json['referral_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      currency: json['currency'] ?? 'XOF',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'balance': balance,
      'avatar': avatar,
      'referral_code': referralCode,
      'referral_count': referralCount,
      'created_at': createdAt.toIso8601String(),
      'currency': currency,
    };
  }
}