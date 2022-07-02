import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:seat_geek_browser/models/event.dart';

class SeatGeekApiProvider {
  static const String _baseUrl = 'https://api.seatgeek.com/2/events';

  Future<List<Event>?> getEvents(String searchQuery) async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    String clientId = remoteConfig.getString('seat_geek_client_id');

    var response = await Dio().get('$_baseUrl?client_id=$clientId&q=$searchQuery').then((response) {
      if (response.statusCode == HttpStatus.ok) {
        return List<Event>.from(response.data['events'].map((model) => Event.fromJson(model)));
      }
      return null;
    }).catchError((e, stackTrace) {
      if (e is DioError) {
        if (e.response?.statusCode == HttpStatus.notFound) {
          debugPrint('No data found');
          return null;
        }
        return null;
      }
      return null;
    });
    return response;
  }
}
