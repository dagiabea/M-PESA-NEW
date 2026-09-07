class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.balance,
    required this.currency,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final double balance;
  final String currency;

  String get firstName {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? name : parts.first;
  }

  String get displayPhone {
    if (phoneNumber.startsWith('+')) return phoneNumber;
    return '+$phoneNumber';
  }
}

class AuthSession {
  const AuthSession({
    required this.user,
    required this.token,
    required this.expiresIn,
  });

  final AuthUser user;
  final String token;
  final int expiresIn;
}
