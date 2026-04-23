import 'package:equatable/equatable.dart';

abstract class DogBreedsEvent extends Equatable {
  const DogBreedsEvent();

  @override
  List<Object?> get props => [];
}

class FetchDogBreeds extends DogBreedsEvent {
  final bool isFromPagination;
  final bool isFromRefresh;
  const FetchDogBreeds({
    this.isFromPagination = false,

    this.isFromRefresh = false,
  });
  @override
  List<Object?> get props => [isFromPagination, isFromRefresh];
}

class SearchDogBreeds extends DogBreedsEvent {
  final String query;

  const SearchDogBreeds(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleSearch extends DogBreedsEvent {
  const ToggleSearch();
}
