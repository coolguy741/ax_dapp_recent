import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracking_repository/tracking_repository.dart';

class _TrackingState {
  const _TrackingState();
}

class TrackingCubit extends Cubit<_TrackingState> {
  TrackingCubit(this.trackingRepository) : super(const _TrackingState());

  final TrackingRepository trackingRepository;
}

extension LandingPageTracking on TrackingCubit {
  void onPressedStartTrading() {
    trackingRepository.track(LandingPageEvent.onPressedStartTrading());
  }
}

extension TradePageTracking on TrackingCubit {
  void onSwapConfirmedTransaction(
    String fromUnits,
    String toUnits,
    String totalFee,
    String walletID,
  ) {
    trackingRepository.trackTradeApproval(
      TradePageUserEvent.onSwapConfirmedTransaction(),
      fromUnits,
      toUnits,
      totalFee,
      walletID,
    );
  }
}

extension TradePageApproveClicked on TrackingCubit {
  void onSwapApproveClick(String fromCurrency) {
    trackingRepository.trackTradeApproveClick(
      TradePageUserEvent.onApproveClick(),
      fromCurrency,
    );
  }
}

extension TradePageConfirmClicked on TrackingCubit {
  void onSwapConfirmClick(String toCurrency) {
    trackingRepository.trackTradeConfirmClick(
      TradePageUserEvent.onConfirmClick(),
      toCurrency,
    );
  }
}
