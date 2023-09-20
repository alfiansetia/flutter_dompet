part of 'transaksi_bloc.dart';

abstract class TransaksiEvent extends Equatable {
  const TransaksiEvent();

  @override
  List<Object> get props => [];
}

class FetchAllTransaksiEvent extends TransaksiEvent {
  const FetchAllTransaksiEvent({required this.page});
  final int page;

  @override
  List<Object> get props => [page];
}
