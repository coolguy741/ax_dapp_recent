import 'package:flutter/material.dart';

class AthletePageToolTip extends StatelessWidget {
  const AthletePageToolTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      showDuration: const Duration(seconds: 3),
      height: 20,
      padding: const EdgeInsets.all(20),
      preferBelow: true,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(50),
      ),
      richMessage: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "Buy/Sell individual APT's at their Market Price\n",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              fontFamily: 'OpenSans',
            ),
          ),
          TextSpan(
            text: 'Mint/Redeem APT Pairs for their Book Value',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
      child: const Icon(
        Icons.info_outline_rounded,
        color: Colors.grey,
        size: 25,
      ),
    );
  }
}
