import 'dart:async';

import 'package:assignment_dog/core/helpers/all_getter.dart';
import 'package:assignment_dog/data/models/dog_breed_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dog_breeds_event.dart';
import 'dog_breeds_state.dart';

class DogBreedsBloc extends Bloc<DogBreedsEvent, DogBreedsState> {
  DogBreedsBloc() : super(const DogBreedsState()) {
    on<FetchDogBreeds>(_onFetchDogBreeds);
    on<SearchDogBreeds>(_onSearchDogBreeds);
    on<ToggleSearch>(_toggleSearch);
    add(const FetchDogBreeds());
  }

  Future<void> _onFetchDogBreeds(
    FetchDogBreeds event,
    Emitter<DogBreedsState> emit,
  ) async {
    final bool isPagination = event.isFromPagination;
    final bool isRefresh = event.isFromRefresh;

    /// 🔹 Prevent duplicate pagination calls
    if (isPagination) {
      if (state.hasReachedMax || state.status == DogBreedsStatus.loadingMore) {
        return;
      }
    }

    /// 🔹 Determine next page correctly
    final int nextPage = isPagination ? state.currentPage + 1 : 1;

    /// 🔹 Emit loading state
    if (isPagination) {
      emit(
        state.copyWith(
          status: DogBreedsStatus.loadingMore,
          currentPage: nextPage,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: DogBreedsStatus.loading,
          breeds: isRefresh ? [] : state.breeds,
          filteredBreeds: isRefresh ? [] : state.filteredBreeds,
          currentPage: 1,
          hasReachedMax: false,
          errorMessage: null,
        ),
      );
    }

    /// 🔹 API CALL
    final result = await Getters.getDogRepo.getDogBreadApi(
      pageNumber: nextPage,
    );

    result.fold(
      /// ❌ FAILURE
      (failure) {
        emit(
          state.copyWith(
            status: DogBreedsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },

      /// ✅ SUCCESS
      (newBreeds) {
        print('state:$state and lenght of the bread is ${newBreeds?.length}');
        final List<DogBreedModel> fetched = newBreeds ?? [];

        /// 🔹 Merge data
        final List<DogBreedModel> updatedBreeds = isPagination
            ? [...state.breeds, ...fetched]
            : fetched;

        /// 🔹 hasReachedMax (correct logic)
        final bool hasReachedMax = fetched.isEmpty;

        /// 🔹 Apply search filter
        final List<DogBreedModel> filtered = state.searchQuery.isNotEmpty
            ? updatedBreeds
                  .where(
                    (b) => b.name!.toLowerCase().contains(
                      state.searchQuery.toLowerCase(),
                    ),
                  )
                  .toList()
            : updatedBreeds;

        /// 🔹 FINAL STATE (ALWAYS update page here ✅)
        emit(
          state.copyWith(
            status: DogBreedsStatus.success,
            breeds: updatedBreeds,
            filteredBreeds: filtered,
            currentPage: nextPage, // ✅ FIXED
            hasReachedMax: hasReachedMax,
            errorMessage: null,
          ),
        );
      },
    );
  }

  void _onSearchDogBreeds(SearchDogBreeds event, Emitter<DogBreedsState> emit) {
    final query = event.query.toLowerCase().trim();
    final filtered = query.isEmpty
        ? state.breeds
        : state.breeds
              .where((b) => b.name!.toLowerCase().contains(query))
              .toList();

    emit(state.copyWith(filteredBreeds: filtered, searchQuery: event.query));
  }

  FutureOr<void> _toggleSearch(
    ToggleSearch event,
    Emitter<DogBreedsState> emit,
  ) {
    emit(
      state.copyWith(
        showSearch: !state.showSearch,
        searchQuery: state.showSearch ? '' : state.searchQuery,
        filteredBreeds: state.showSearch ? state.breeds : state.filteredBreeds,
      ),
    );
  }
}
