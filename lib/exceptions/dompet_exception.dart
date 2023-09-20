class DompetException implements Exception {
  DompetException([this.message = 'Something went wrong']) {
    message = 'Dompet Exception: $message';
  }

  String message;

  @override
  String toString() {
    return message;
  }
}
