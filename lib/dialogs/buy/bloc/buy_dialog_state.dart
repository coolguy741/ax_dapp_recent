part of 'buy_dialog_bloc.dart';

class BuyDialogState extends Equatable {
  const BuyDialogState({
    this.status = BlocStatus.initial,
    this.aptTypeSelection = AptType.long,
    this.longApt = const Apt.empty(),
    this.shortApt = const Apt.empty(),
    this.balance = 0,
    this.axInputAmount = 0,
    this.aptBuyInfo = AptBuyInfo.empty,
    this.errorMessage = '',
    this.failure = Failure.none,
  });

  final AptType aptTypeSelection;
  final Apt longApt;
  final Apt shortApt;
  final double balance;
  final double axInputAmount;
  final BlocStatus status;
  final AptBuyInfo aptBuyInfo;
  final String errorMessage;
  final Failure failure;

  @override
  List<Object> get props {
    return [
      aptTypeSelection,
      longApt,
      shortApt,
      balance,
      axInputAmount,
      status,
      aptBuyInfo,
      errorMessage,
      failure,
    ];
  }

  BuyDialogState copyWith({
    AptType? aptTypeSelection,
    Apt? longApt,
    Apt? shortApt,
    double? balance,
    double? axInputAmount,
    BlocStatus? status,
    AptBuyInfo? aptBuyInfo,
    String? errorMessage,
    Failure? failure,
  }) {
    return BuyDialogState(
      aptTypeSelection: aptTypeSelection ?? this.aptTypeSelection,
      longApt: longApt ?? this.longApt,
      shortApt: shortApt ?? this.shortApt,
      balance: balance ?? this.balance,
      axInputAmount: axInputAmount ?? this.axInputAmount,
      status: status ?? this.status,
      aptBuyInfo: aptBuyInfo ?? this.aptBuyInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      failure: failure ?? this.failure,
    );
  }
}

extension BuyDialogStateX on BuyDialogState {
  String get selectedAptAddress =>
      aptTypeSelection.isLong ? longApt.address : shortApt.address;
}
class InSufficientFailure extends Failure {
  /// {@macro temp_failure}
  InSufficientFailure()
      : super(Exception('Insufficent Failure'), StackTrace.empty);
}
