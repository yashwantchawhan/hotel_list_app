
import 'package:design_common/design_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venue_list/presentation/bloc/venue_bloc.dart';
import 'package:venue_list/presentation/bloc/venue_event.dart';
import 'package:venue_list/presentation/bloc/venue_state.dart';
import 'package:venue_map/venue_map.dart';

class VenueListScreen extends StatefulWidget {
  const VenueListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VenueListScreenState();
}

class _VenueListScreenState extends State<VenueListScreen> {
  late VenueBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<VenueBloc>();
    _bloc.add(const FetchVenue());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeader(),
          _buildChips(),
          _buildList(),
        ],
      ),
      floatingActionButton: FilterAndMapButton(
        onFilterTap: () {
          _bloc.add(const FilterViewEvent());
        },
        onMapTap: () {
          _bloc.add(const MapViewEvent());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 30,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child:  TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            onChanged: (value){
              _onSearchQueryChanged(value);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChips() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          children: const [
            SelectableChip(label: 'Pool'),
            SizedBox(width: 20),
            SelectableChip(label: 'Gym'),
            SizedBox(width: 20),
            SelectableChip(label: 'Beach'),
            SizedBox(width: 20),
            SelectableChip(label: 'Family'),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {

    return BlocConsumer<VenueBloc, VenueState>(
      bloc: _bloc,
      buildWhen: _buildWhen,
      listenWhen: _listenWhen,
      listener: _onStateChangeListener,
      builder: (context, state) => _onStateChangeBuilder(
        context,
        state,
      ),
    );
  }

  void _onStateChangeListener(BuildContext context, VenueState state) {
    if (state is VenueMapViewState) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
            venues: state.venueItemList,
          ),
        ),
      );
    } else if(state is FilterViewEvent) {
      showFilterBottomSheet(context);
    }
  }


  bool _buildWhen(
      VenueState previous,
      VenueState current,
      ) =>
      current is VenueLoadedState || current is VenueErrorState;

  bool _listenWhen(
      VenueState previous,
      VenueState current,
      ) =>
      true;

  _onStateChangeBuilder(BuildContext context, VenueState state) {
    if (state is VenueLoadedState) {
      final venues = state.venueItemList;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final venue = venues[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: VenueCard(
                configuration: VenueCardConfiguration(
                  imageUrls: venue.imageUrls,
                  title: venue.name,
                  subtitle: venue.location,
                ),
              ),
            );
          },
          childCount: venues.length,
        ),
      );
    }
    else if (state is VenueErrorState) {
      return const SliverFillRemaining(
        child: Center(child: Text("Error loading venues")),
      );
    } else {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }

  void _onSearchQueryChanged(String query) {
    Future.delayed(const Duration(milliseconds: 200));
      if (query.isEmpty) {
        _bloc.add(const FetchVenue());
      } else {
        _bloc.add(SearchVenueEvent(query: query));
      }
  }
}



