class TransaksiException implements Exception {
  TransaksiException([this.message = 'Something went wrong']) {
    message = 'Transaksi Exception: $message';
  }

  String message;

  @override
  String toString() {
    return message;
  }
}
