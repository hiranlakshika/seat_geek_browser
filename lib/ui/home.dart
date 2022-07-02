import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../blocs/seat_geek_bloc.dart';
import '../util/custom_search_delegate.dart';

class HomePage extends StatelessWidget {
  final SeatGeekBloc _seatGeekBloc = GetIt.I<SeatGeekBloc>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate()),
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      body: FutureBuilder(
          future: _seatGeekBloc.initRemoteConfig(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasData) {
              debugPrint('Firebase Remote Config initialized');
            }
            return const SizedBox();
          }),
    );
  }
}
