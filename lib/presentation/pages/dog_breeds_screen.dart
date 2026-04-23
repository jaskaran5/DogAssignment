import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/dog_breeds/dog_breeds_bloc.dart';
import '../blocs/dog_breeds/dog_breeds_event.dart';
import '../blocs/dog_breeds/dog_breeds_state.dart';
import '../widgets/dog_breed_card.dart';

class DogBreedsScreen extends StatefulWidget {
  const DogBreedsScreen({super.key});

  @override
  State<DogBreedsScreen> createState() => _DogBreedsScreenState();
}

class _DogBreedsScreenState extends State<DogBreedsScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bloc = context.read<DogBreedsBloc>();
    final state = bloc.state;
    if (_isBottom &&
        state.status == DogBreedsStatus.success &&
        !state.hasReachedMax) {
      bloc.add(const FetchDogBreeds(isFromPagination: true));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    return current >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<DogBreedsBloc>().state;
    final bloc = context.read<DogBreedsBloc>();
    return Scaffold(
      appBar: AppBar(
        title: state.showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search breeds...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: .7),
                  ),
                  border: InputBorder.none,
                  filled: false,
                ),
                onChanged: (q) =>
                    context.read<DogBreedsBloc>().add(SearchDogBreeds(q)),
              )
            : const Text('Dog Breeds'),
        actions: [
          IconButton(
            icon: Icon(state.showSearch ? Icons.close : Icons.search),
            onPressed: () {
              bloc.add(ToggleSearch());

              if (!state.showSearch) {
                _searchController.clear();
                bloc.add(const SearchDogBreeds(''));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
            onPressed: () {
              _searchController.clear();
              state.copyWith(showSearch: false);
              bloc.add(const FetchDogBreeds(isFromRefresh: true));
            },
          ),
        ],
      ),
      body: BlocBuilder<DogBreedsBloc, DogBreedsState>(
        builder: (context, state) {
          switch (state.status) {
            case DogBreedsStatus.initial:
            case DogBreedsStatus.loading:
              return _buildLoading();

            case DogBreedsStatus.failure:
              return _buildError(state.errorMessage ?? 'Unknown error', bloc);

            case DogBreedsStatus.success:
            case DogBreedsStatus.loadingMore:
              if (state.filteredBreeds.isEmpty) {
                return _buildEmpty(state.searchQuery, bloc);
              }
              return _buildList(state, bloc);
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading breeds...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message, DogBreedsBloc bloc) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: const Text('😕', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 20),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => bloc.add(const FetchDogBreeds()),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(String searchQuery, DogBreedsBloc bloc) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty
                ? 'No results for "$searchQuery"'
                : 'No breeds found',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          if (searchQuery.isNotEmpty) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                _searchController.clear();
                bloc.add(const SearchDogBreeds(''));
              },
              child: const Text('Clear search'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildList(DogBreedsState state, DogBreedsBloc bloc) {
    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(const FetchDogBreeds(isFromRefresh: true));
      },
      color: const Color(0xFF2E7D32),
      child: Column(
        children: [
          // Stats bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F8E9),
              border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
            ),
            child: Row(
              children: [
                const Icon(Icons.pets, size: 16, color: Color(0xFF2E7D32)),
                const SizedBox(width: 6),
                Text(
                  state.searchQuery.isNotEmpty
                      ? '${state.filteredBreeds.length} results for "${state.searchQuery}"'
                      : '${state.breeds.length} breeds loaded',
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (state.status == DogBreedsStatus.loadingMore)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount:
                  state.filteredBreeds.length +
                  (state.status == DogBreedsStatus.loadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.filteredBreeds.length) {
                  return const _LoadMoreIndicator();
                }
                return DogBreedCard(breed: state.filteredBreeds[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadMoreIndicator extends StatelessWidget {
  const _LoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text('Loading more breeds...'),
          ],
        ),
      ),
    );
  }
}
