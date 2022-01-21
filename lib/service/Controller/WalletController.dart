import 'package:ax_dapp/service/Controller/Swap/AXT.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'Controller.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class WalletController extends GetxController {
  var axPrice = "-".obs;
  var axCirculation = "-".obs;
  var axTotalSupply = "-".obs;
  var yourBalance = 0.0.obs;

  void getYourAXBalance() async {
    update();
  }

  // Update circulating Supply, price, total supply in one call
  void getTokenMetrics() async {
    var coinGeckoUrl =
        Uri.parse("https://api.coingecko.com/api/v3/coins/athletex");
    var tokenMetrics = await http.get(coinGeckoUrl);
    if (tokenMetrics.statusCode == 200) {
      // if the request is successful -> get values
      var jsonTokenMetrics = json.decode(tokenMetrics.body);
      var ap = jsonTokenMetrics['market_data']['current_price']['usd'];
      if (ap != null) {
        axPrice.value = "$ap";
      }
      var ts = jsonTokenMetrics['market_data']['total_supply'];
      if (ts != null) {
        axTotalSupply.value = "$ts";
      }
      var ac = jsonTokenMetrics['market_data']['circulating_supply'];
      if (ac != 0) {
        axCirculation.value = "$ac";
      }
    } else {
      // if bad request -> throw Exception
      throw Exception('Failed to fetch the data from congecko api');
    }

    print(
        "[Console] AX Price: $axPrice, AX TotalSupply: $axTotalSupply, AX Circulation: $axCirculation");
    update();
  }

  // Update token balance
  void getTokenBalance() async {
    Controller controller = Get.find();
    var theClient = controller.client.value;
    var account = controller.publicAddress.value;
    var address = EthereumAddress.fromHex(AXT.polygonAddress);
    var ax = Erc20(address: address, client: theClient);
    BigInt rawBalance = await ax.balanceOf(account);
    yourBalance.value = rawBalance.toDouble();
    print("AX Blance: $yourBalance");
    update();
  }

  void addTokenToWallet() async {}
}
