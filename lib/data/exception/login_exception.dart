class LoginException implements Exception {
  LoginException([this.message = 'Something went wrong']) {
    message = 'Loginx Exception: $message';
  }

  String message;

  @override
  String toString() {
    return message;
  }
}
