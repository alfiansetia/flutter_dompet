part of 'transaksi_bloc.dart';

@freezed
class TransaksiEvent with _$TransaksiEvent {
  const factory TransaksiEvent.started() = _Started;
  const factory TransaksiEvent.getAll() = _GetAll;
  const factory TransaksiEvent.getDetail(int id) = _GetDetail;
}
