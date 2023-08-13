import 'dart:convert';
import 'package:covid19_tracker/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker/Model/world_stats_model.dart';


class StatsServices{
  Future<WorldStatsModel> fetchWorldStatsRecords () async {
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }
}