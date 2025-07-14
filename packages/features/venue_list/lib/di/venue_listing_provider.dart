import 'package:datasource_core/datasource_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:venue_list/presentation/bloc/venue_bloc.dart';
import 'package:venue_list/presentation/widgets/venue_list_screen.dart';
class VenueListingProvider extends StatelessWidget {
  const VenueListingProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (_) => VenueBloc(VenueRepository()),
      child: const VenueListScreen(),
    );
  }
}