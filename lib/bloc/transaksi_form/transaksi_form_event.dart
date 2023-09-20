part of 'transaksi_form_bloc.dart';

abstract class TransaksiFormEvent extends Equatable {
  const TransaksiFormEvent();

  @override
  List<Object> get props => [];
}

class DetailTransaksiFormEvent extends TransaksiFormEvent {
  DetailTransaksiFormEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}

class AddTransaksiFormEvent extends TransaksiFormEvent {
  AddTransaksiFormEvent({
    required this.id,
  });

  final Transaksi id;

  @override
  List<Object> get props => [id];
}

class DeleteTransaksiFormEvent extends TransaksiFormEvent {
  DeleteTransaksiFormEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}
