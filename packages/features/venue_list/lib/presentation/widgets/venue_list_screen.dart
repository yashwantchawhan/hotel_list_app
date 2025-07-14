
import 'package:datasource_core/datasource_core.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:design_common/design_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venue_details/presentation/widgets/venue_details_screen.dart';
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
            decoration: const InputDecoration(
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


  Widget _buildChips(List<FilterItem> filters) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final category = filters[index];
            return SelectableChip(label: category.name);
          },
        ),
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
    } else if(state is FilterViewState) {
      showFilterBottomSheet(context);
    } else if(state is VenueDetailState) {
       Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VenueDetailsScreen(venue: state.venueItem),
         ),
      );
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
      final venues = state.venueDataDisplayModel.venues;

      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildHeader(),
            _buildChips(state.venueDataDisplayModel.filters),
             buildSliverList(venues),
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
    else if (state is VenueErrorState) {
      return
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Text(
              state.errorMessage,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        );

    }
    else {
      return
       const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: CircularProgressIndicator(),
          ),
        );

    }
  }

  SliverList buildSliverList(List<VenueItem> venues) {
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
              onCardClick: () {
                _bloc.add(VenueDetailsEvent(name: venue.name));
              },
            ),
          );
        },
        childCount: venues.length,
      ),
    );
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





