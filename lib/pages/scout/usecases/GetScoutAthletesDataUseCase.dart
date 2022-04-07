import 'package:ax_dapp/pages/scout/models/AthleteScoutModel.dart';
import 'package:ax_dapp/repositories/SportsRepo.dart';
import 'package:ax_dapp/service/athleteModels/SportAthlete.dart';
import 'package:ax_dapp/util/SupportedSports.dart';

class GetScoutAthletesDataUseCase {
  final Map<SupportedSport, SportsRepo<SportAthlete>> _repos = Map();

  GetScoutAthletesDataUseCase(List<SportsRepo<SportAthlete>> sportsRepos) {
    sportsRepos.forEach((repo) {
      _repos[repo.sport] = repo;
    });
  }

  Future<List<AthleteScoutModel>> fetchSupportedAthletes(
      SupportedSport sportSelection) async {
    /// If specific sport is selected return athletes from that specific repo
    if (sportSelection != SupportedSport.ALL) {
      var repo = _repos[sportSelection]!;
      final List<SportAthlete> response = await repo.getSupportedPlayers();
      return _mapAthleteToScoutModel(response, repo);
    } else {
      /// if ALL sports is selected fetch for each sport and add athletes to a
      /// combined list
      final athletes = <AthleteScoutModel>[];
      final response = await Future.wait(_repos
          .map((key, repo) => MapEntry(key, repo.getSupportedPlayers()))
          .values);
      response.asMap().forEach((key, response) {
        athletes.addAll(_mapAthleteToScoutModel(response, _repos.values.elementAt(key)));
      });
      return athletes;
    }
  }

  List<AthleteScoutModel> _mapAthleteToScoutModel(
      List<SportAthlete> athletes, SportsRepo<SportAthlete> repo) {
    return athletes
        .map((athlete) => AthleteScoutModel(
              athlete.id,
              athlete.name,
              athlete.position,
              athlete.team,
              athlete.price,
              repo.sport,
            ))
        .toList();
  }
}
