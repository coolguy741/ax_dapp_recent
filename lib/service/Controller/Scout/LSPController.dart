// ignore_for_file: non_constant_identifier_names
import 'package:ax_dapp/service/Controller/Swap/AXT.dart';
import 'package:ax_dapp/service/Controller/APT.dart';
import 'package:get/get.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import '../../../contracts/LongShortPair.g.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:http/http.dart';
import '../Controller.dart';

// --> Joe burrow
// --> Jamaar chase
// --> Matthew Stafford
// --> Cooper Kupp

class LSPController extends GetxController {
  Controller controller = Get.find();
  late LongShortPair genericLSP;
  var createAmt = 0.0.obs;
  var redeemAmt = 0.0.obs;
  var aptAddress = ''.obs;
  final tokenClient =
      Web3Client("https://matic-mumbai.chainstacklabs.com", new Client());
  // Hard address listing of all Athletes

  LSPController();

  Future<void> mint() async {
    EthereumAddress address = EthereumAddress.fromHex(aptAddress.value);
    genericLSP = LongShortPair(address: address, client: tokenClient);
    print("Attempting to MINT LSP");
    print(await controller.credentials.extractAddress());
    final theCredentials = controller.credentials;
    BigInt tokensToCreate =
        BigInt.from(createAmt.value) * BigInt.from(1000000000000000000);

    // approve().then((value) async {
    // });
    approve().then((value) async {
      String txString =
          await genericLSP.create(tokensToCreate, credentials: theCredentials);
      controller.updateTxString(txString); //Sends tx to controller
    });
  }

  Future<void> approve() async {
    print("collaterall amount: ${await genericLSP.collateralPerPair()}");
    EthereumAddress address = EthereumAddress.fromHex(aptAddress.value);
    genericLSP = LongShortPair(address: address, client: tokenClient);
    BigInt transferAmount = BigInt.parse("1000000000000000000000000000");
    BigInt amount = BigInt.from(createAmt.value) * transferAmount;
    print("[Console] Inside approve()");
    EthereumAddress axtaddress = EthereumAddress.fromHex(AXT.mumbaiAddress);
    Erc20 axt = Erc20(address: axtaddress, client: tokenClient);
    try {
      print("[Console] Created a token variable.");
    } catch (error) {
      print(error);
    }
    EthereumAddress spender = EthereumAddress.fromHex(aptAddress.value);
    String txString =
        await axt.approve(address, amount, credentials: controller.credentials);
  }

  Future<void> redeem() async {
    EthereumAddress address = EthereumAddress.fromHex(aptAddress.value);
    genericLSP = LongShortPair(address: address, client: tokenClient);
    final theCredentials = controller.credentials;
    BigInt tokensToRedeem = BigInt.from(redeemAmt.value);
    genericLSP.redeem(tokensToRedeem, credentials: theCredentials);
  }

  void updateAptAddress(int athleteId) {
    if (AXT.idToAddress.containsKey(athleteId)) {
      aptAddress.value = AXT.idToAddress[athleteId] as String;
    }
    print("[Console] Updated the aptAddress to $aptAddress");
    update();
  }

  void updateCreateAmt(double newAmount) {
    createAmt.value = newAmount;
    print("creating lsps with collateral: $newAmount");
    update();
  }

  void updateRedeemAmt(double newAmount) {
    redeemAmt.value = newAmount;
    print("redeeming lsps with collateral: $newAmount");
    update();
  }

  Future<void> updateCollateralAmount() async {}
}
