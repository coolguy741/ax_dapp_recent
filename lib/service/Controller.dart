import 'dart:html';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/browser.dart';
import 'package:bip39/bip39.dart'
    as bip39; // Basics of BIP39 https://coldbit.com/bip-39-basics-from-randomness-to-mnemonic-words/

class Controller {
  static var client;
  static var credentials;
  static var publicAddress;
  Controller._privateConstructor();

  static final Controller _instance = Controller._privateConstructor();

  /// VARIABLES
  var rng = new Random().nextInt(999);
  var mnemonic;
  var privateAddress;
  bool activeChain = false;
  static const MAINNET_CHAIN_ID = 137;
  String mainRPCUrl = "https://polygon-rpc.com";
  String testRPCUrl = "https://matic-mumbai.chainstacklabs.com/";

  set axTokenAddress(EthereumAddress tokenAddress) {
    axTokenAddress = EthereumAddress.fromHex("${tokenAddress.hex}");
  }

  factory Controller() {
    return _instance;
  }

  void createNewMnemonic() {
    mnemonic = bip39.generateMnemonic();
  }

  Future<String> retrieveWallet([String? _mnemonic]) async {
    mnemonic = _mnemonic;
    privateAddress = bip39.mnemonicToSeedHex(mnemonic);
    credentials = EthPrivateKey.fromHex(privateAddress);
    return mnemonic;
  }

  // Web functionality
  static void connect() async {
    final eth = window.ethereum;
    var newClient = Web3Client.custom(eth!.asRpcService());
    final credentials = await eth.requestAccount();
    print("[Console] connecting to the decentralized web!");
    update(newClient, credentials);
  }

  static void update(Web3Client cl, Credentials cr) async {
    client = cl;
    credentials = cr;
    publicAddress = await cr.extractAddress();
    print("[Console] updated client: ${cl} and credentials: ${cr}");
  }

  void viewTx(String txAddress) async {
    String urlString = 'https://polygonscan.com/tx/$txAddress';
    await launch(urlString);
  }
}
