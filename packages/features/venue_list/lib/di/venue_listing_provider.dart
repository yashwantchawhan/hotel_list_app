import 'package:datasource_core/datasource_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venue_list/domain/venue_data_model_mapper.dart';
import 'package:venue_list/domain/venue_details_model_mapper.dart';
import 'package:venue_list/presentation/bloc/venue_bloc.dart';
import 'package:venue_list/presentation/widgets/venue_list_screen.dart';

class VenueListingProvider extends StatelessWidget {
  const VenueListingProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VenueBloc(VenueRepository(),
          VenueDetailsModelMapperImpl(),
          VenueDataModelMapperImpl()),
      child: const VenueListScreen(),
    );
  }
}
