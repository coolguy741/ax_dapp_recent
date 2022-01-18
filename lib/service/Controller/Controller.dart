// ignore_for_file: implementation_imports, avoid_web_libraries_in_flutter, invalid_use_of_internal_member

import 'dart:html';

import 'dart:math';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';
import 'package:get/get.dart';
import 'package:web3dart/browser.dart';
import 'package:bip39/bip39.dart'
    as bip39; // Basics of BIP39 https://coldbit.com/bip-39-basics-from-randomness-to-mnemonic-words/

class Controller extends GetxController {
  /// VARIABLES
  var seedHex = "";
  var credentials;
  var mnemonic = "";
  var networkID = 0.obs;
  bool activeChain = false;
  int ACTIVE_CHAIN_ID = 137;
  static String latestTx = "";
  bool walletConnected = false;
  var gas = EtherAmount.zero().obs;
  static const MAINNET_CHAIN_ID = 137;
  static const TESTNET_CHAIN_ID = 80001;
  String mainRPCUrl = "https://polygon-rpc.com";
  String testRPCUrl = "https://matic-mumbai.chainstacklabs.com/";
  var client = Web3Client("url", Client()).obs;
  var publicAddress =
      EthereumAddress.fromHex("0xcdaa8c55fB92fbBE61948aDf4Ba8Cf7Ad33DBeF0").obs;

  set axTokenAddress(EthereumAddress tokenAddress) {
    axTokenAddress = EthereumAddress.fromHex("${tokenAddress.hex}");
  }

  Controller() {
    initState();
  }

  void initState() async {
    getCurrentGas();
  }

  // This will create mnemonics & convert to seed hexes
  void createNewMnemonic() {
    mnemonic = bip39.generateMnemonic();
    seedHex = bip39.mnemonicToSeedHex(mnemonic);
    update();
  }

  // This will import mnemonics & convert to seed hexes
  Future<bool> importMnemonic(String _mnemonic) async {
    // validate if mnemonic
    bool isValid = await bip39.validateMnemonic(_mnemonic);
    if (isValid) {
      seedHex = bip39.mnemonicToSeedHex(_mnemonic);
      mnemonic = _mnemonic;
    }
    return isValid;
  }

  // Connect the dapp to metamask and update relevant values
  void connect() async {
    final eth = window.ethereum;
    walletConnected = true;
    client.value = Web3Client.custom(eth!.asRpcService());
    credentials = await eth.requestAccount();
    print("[Console] connecting to the decentralized web!");
    networkID.value = await client.value.getNetworkId();
    publicAddress.value = await credentials.extractAddress();
    gas.value = await client.value.getGasPrice();
    print("[Console] updated client: $client and credentials: $credentials");
    update();
  }

  // Connect the client + set credentials
  void connectNative() async {
    walletConnected = true;

    String rpcUrl = "";
    switch (ACTIVE_CHAIN_ID) {
      case 137:
        rpcUrl = mainRPCUrl;
        break;
      default:
        rpcUrl = testRPCUrl;
    }

    client.value = Web3Client(rpcUrl, Client());
    credentials = EthPrivateKey.fromHex(seedHex);
    print("[Console] connecting to the decentralized web!");
    networkID.value = await client.value.getNetworkId();
    publicAddress.value = await credentials.extractAddress();
    gas.value = await client.value.getGasPrice();
    print("[Console] updated client: $client and credentials: $credentials");
    update();
  }

  void getCurrentGas() async {
    final eth = window.ethereum;
    gas.value = await Web3Client.custom(eth!.asRpcService())
        .getBalance(publicAddress.value);
  }

  void updateTxString(String tx) {
    print("latest txString: $tx");
    latestTx = tx;
  }

  void disconnect() async {
    final eth = window.ethereum;
    walletConnected = eth!.isConnected();
    client.value.dispose();
    client.value.getChainId();

    update();
  }

  static void switchNetwork() async {
    final eth = window.ethereum;
    Object params = [
      {'chainID': '0xf00'}
    ];
    eth!.rawRequest('wallet_switchEthereumChain', params: {params});
  }

  static void viewTx() async {
    String urlString = "";
    latestTx == ""
        ? urlString = "https://mumbai.polygonscan.com"
        : urlString = 'https://mumbai.polygonscan.com/tx/$latestTx';
    await launch(urlString);
  }
}
