import 'package:flip/components/Common/CustomButton.dart';
import 'package:flip/components/Common/CustomTextField.dart';
import 'package:flip/components/Common/SnackBar.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = '';
  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
      amount: widget.totalAmount,
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    pinCodeController.dispose();
    areaController.dispose();
    cityController.dispose();

    super.dispose();
  }

  void onApplePayResult(result) {
    print(result);
  }

  void onGPayResult(result) {
    print(result);
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${pinCodeController.text} - ${cityController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Address not vaild!');
    }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserProvider>(context).user.address
    var address = "101,Fake address";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text(
            'Update Address',
            style: TextStyle(fontSize: 17),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Visibility(
                visible: address.isNotEmpty,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Form(
                key: _addressFormKey,
                child: Column(children: [
                  CustomTextField(
                    placeHolder: 'Flat, House no, BUilding',
                    controller: flatBuildingController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    placeHolder: 'Area Street',
                    controller: areaController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    placeHolder: 'Pincode',
                    controller: pinCodeController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    placeHolder: 'Town/City',
                    controller: cityController,
                  ),
                  const SizedBox(height: 10),
                ]),
              ),
              ApplePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                style: ApplePayButtonStyle.black,
                type: ApplePayButtonType.buy,
                paymentConfigurationAsset: 'applepay.json',
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
                height: 50,
                margin: const EdgeInsets.only(top: 50),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                type: GooglePayButtonType.buy,
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGPayResult,
                paymentItems: paymentItems,
                height: 50,
                margin: const EdgeInsets.only(top: 50),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
