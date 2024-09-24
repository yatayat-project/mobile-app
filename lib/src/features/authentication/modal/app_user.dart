import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.userID,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userID, accessToken];

  final int userID;
  final String accessToken;
}
