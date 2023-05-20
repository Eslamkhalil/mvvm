import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final controller = CardFormEditController();

  @override
  void initState() {
    controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});
  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Fees'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Card Form',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            CardFormField(
              controller: controller,
              enablePostalCode: false,
              countryCode: 'EG',
              style: CardFormStyle(backgroundColor: Colors.black45),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.details.complete == true) {
                  makePayment(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('check add inputs')));
                }
              },
              child: Text(
                'Pay',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(context) async {
    try {
      final paymentIntent = await createPaymentIntent('10000', 'EG', context);

      // var gpay = PaymentSheetGooglePay(
      //     merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

      await Stripe.instance
          .confirmPayment(
            paymentIntentClientSecret:
                paymentIntent!['client_secret'], //Gotten from payment intent

            data: const PaymentMethodParams.card(
              paymentMethodData: PaymentMethodData(
                billingDetails: BillingDetails(
                  email: 'test@gmail.com',
                  name: 'Manar',
                  phone: '01111111111',
                ),
              ),
            ),
          )
          .then((value) => {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${value.status}'))),
              });

      // //STEP 2: Initialize Payment Sheet
      // await Stripe.instance
      //     .initPaymentSheet(
      //         paymentSheetParameters: SetupPaymentSheetParameters(
      //             paymentIntentClientSecret: paymentIntent![
      //                 'client_secret'], //Gotten from payment intent
      //             style: ThemeMode.system,
      //             // customerId: paymentIntent!['customer'],
      //             // customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
      //             merchantDisplayName: 'Eslam Khalil',
      //             googlePay: gpay))
      //     .then((value) {});

      // //STEP 3: Display Payment sheet
      // displayPaymentSheet(context);
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $err')));
    }
  }

  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment Successfully')));
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      log('$e');
    }
  }

  createPaymentIntent(String amount, String currency, context) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51AOueMDM3FsBOMzartKe7uq7OTsuHBjDp75WiEL4zf3BA4veQdkFtPoitJHZA4UQ7lc3YnxyI3dXbXC6to4Bue8i00rbgidm38',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log(' respose is ${response.body}');
      return json.decode(response.body);
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $err')));
      throw Exception(err.toString());
    }
  }


}
