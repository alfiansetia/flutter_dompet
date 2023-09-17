part of 'transaksi_bloc.dart';

abstract class TransaksiEvent extends Equatable {
  const TransaksiEvent();

  @override
  List<Object> get props => [];
}

class FetchAllTransaksiEvent extends TransaksiEvent {
  const FetchAllTransaksiEvent();

  @override
  List<Object> get props => [];
}

class FetchShowTransaksiEvent extends TransaksiEvent {
  final String id;

  FetchShowTransaksiEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
