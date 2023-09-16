part of 'transaksi_bloc.dart';

@freezed
class TransaksiState with _$TransaksiState {
  const factory TransaksiState.initial() = _Initial;
  const factory TransaksiState.loading() = _Loading;
  const factory TransaksiState.loaded(TransaksisResponseModel model) = _Loaded;
  const factory TransaksiState.detailLoaded(Transaksi model) = _DetailLoaded;
  const factory TransaksiState.error(String message) = _Error;
}
