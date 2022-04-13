import 'package:ax_dapp/util/SupportedSports.dart';

class AthleteScoutModel {
  final int id;
  final String name;
  final String position;
  final String team;
  final double warPrice;
  late double bookPrice;
  static const collateralizationMultiplier = 1000;
  final SupportedSport sport;
  final String time;
  final double homeRuns;
  final double strikeOuts;
  final double saves;
  final double stolenBase;

  AthleteScoutModel(
      this.id,
      this.name,
      this.position,
      this.team,
      this.warPrice,
      this.sport,
      this.time,
      this.homeRuns,
      this.strikeOuts,
      this.saves,
      this.stolenBase) {
    this.bookPrice = this.warPrice * collateralizationMultiplier;
  }
}
