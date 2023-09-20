part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({required this.index});

  final int index;

  factory NavigationState.initial() => NavigationState(index: 0);

  @override
  List<Object> get props => [index];

  NavigationState copyWith({
    int? index,
  }) {
    return NavigationState(
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'NavigationState(index: $index)';
}
