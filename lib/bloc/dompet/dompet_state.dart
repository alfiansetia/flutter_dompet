part of 'dompet_bloc.dart';

@freezed
class DompetState with _$DompetState {
  const factory DompetState.initial() = _Initial;
  const factory DompetState.loading() = _Loading;
  const factory DompetState.loaded(DompetsResponseModel model) = _Loaded;
  const factory DompetState.detailLoaded(Dompet model) = _DetailLoaded;
  const factory DompetState.error(String message) = _Error;
}
