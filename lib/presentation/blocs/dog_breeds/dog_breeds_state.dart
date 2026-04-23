import 'package:assignment_dog/data/models/dog_breed_model.dart';
import 'package:equatable/equatable.dart';

enum DogBreedsStatus { initial, loading, loadingMore, success, failure }

class DogBreedsState extends Equatable {
  final DogBreedsStatus status;
  final List<DogBreedModel> breeds;
  final List<DogBreedModel> filteredBreeds;
  final String? errorMessage;
  final int currentPage;
  final bool hasReachedMax;
  final bool showSearch;
  final String searchQuery;

  const DogBreedsState({
    this.status = DogBreedsStatus.initial,
    this.breeds = const [],
    this.filteredBreeds = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.searchQuery = '',
    this.showSearch = false,
  });

  DogBreedsState copyWith({
    DogBreedsStatus? status,
    List<DogBreedModel>? breeds,
    List<DogBreedModel>? filteredBreeds,
    String? errorMessage,
    int? currentPage,
    bool? hasReachedMax,
    String? searchQuery,
    bool? showSearch,
  }) {
    return DogBreedsState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
      filteredBreeds: filteredBreeds ?? this.filteredBreeds,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
      showSearch: showSearch ?? this.showSearch,
    );
  }

  @override
  List<Object?> get props => [
    status,
    breeds,
    filteredBreeds,
    errorMessage,
    currentPage,
    hasReachedMax,
    searchQuery,
    showSearch,
  ];

  @override
  String toString() =>
      'DogBreedsState { status: $status, breeds: ${breeds.length}, page: $currentPage }';
}
