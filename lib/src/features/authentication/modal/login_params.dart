import '../../../models/params/index.dart';

class LoginParams extends Params {
  final String phone;
  final String password;

  LoginParams({required this.phone, required this.password});

  @override
  Params clone() {
    return LoginParams(phone: phone, password: password);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
