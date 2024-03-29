import 'package:bloc_bases/data/model/film_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class InitialHomeState extends HomeState {}

class EmptyHomeState extends HomeState {}

class SuccessHomeState extends HomeState {
  final List<FilmModel> result;
  SuccessHomeState(this.result);
}

class ErrorHomeState extends HomeState {}
