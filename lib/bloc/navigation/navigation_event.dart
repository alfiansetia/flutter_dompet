part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationSetEvent extends NavigationEvent {
  NavigationSetEvent({
    required this.index,
  });

  final int index;

  @override
  List<Object> get props => [index];
}
