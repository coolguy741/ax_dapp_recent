import 'package:ax_dapp/app/config/app_config.dart';
import 'package:ax_dapp/service/api/models/player_ids.dart';
import 'package:ax_dapp/service/athlete_models/athlete_price_record.dart';
import 'package:ax_dapp/service/athlete_models/mlb/mlb_athlete.dart';
import 'package:ax_dapp/service/athlete_models/mlb/mlb_athlete_stats.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'mlb_athlete_api.g.dart';

@RestApi(baseUrl: '$baseApiUrl/mlb')
abstract class MLBAthleteAPI {
  factory MLBAthleteAPI(Dio dio, {String baseUrl}) = _MLBAthleteAPI;

  @GET('/players')
  Future<List<MLBAthlete>> getAllPlayers();

  @POST('/players')
  Future<List<MLBAthlete>> getPlayersById(@Body() PlayerIds playerIds);

  @GET('/players/{id}')
  Future<MLBAthlete> getPlayer(@Path() int id);

  @GET('/players')
  Future<List<MLBAthlete>> getPlayersByTeam(@Query('team') String team);

  @GET('/players')
  Future<List<MLBAthlete>> getPlayersByPosition(
      @Query('position') String position,);

  @GET('/players')
  Future<List<MLBAthlete>> getPlayersByTeamAtPosition(@Query('team') String team,
      @Query('position') String position,);

  @GET('/players/{id}/history')
  Future<MLBAthleteStats> getPlayerHistory(@Path() int id,
      @Query('from') String from,
      @Query('until') String until,);

  @GET('/players/{id}/history/price')
  Future<AthletePriceRecord> getPlayerPriceHistory(
    @Path() int id,
    @Query('from') String? from,
    @Query('until') String? until,
    @Query('interval') String interval,
  );

  @POST('/players/history')
  Future<List<MLBAthleteStats>> getPlayersHistory(
    @Body() PlayerIds playerIds,
    @Query('from') String from,
    @Query('until') String until,
  );

  @POST('/players/history/price')
  Future<List<AthletePriceRecord>> getPlayersPriceHistory(
    @Body() PlayerIds playerIds,
    @Query('from') String? from,
    @Query('until') String? until,
    @Query('interval') String interval,
  );
}
