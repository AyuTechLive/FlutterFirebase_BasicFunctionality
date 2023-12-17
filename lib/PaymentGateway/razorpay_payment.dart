import 'package:flutter/material.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RaxorpayPayment extends StatefulWidget {
  const RaxorpayPayment({super.key});

  @override
  State<RaxorpayPayment> createState() => _RaxorpayPaymentState();
}

class _RaxorpayPaymentState extends State<RaxorpayPayment> {
  final _razorpay = Razorpay();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Utils().toastMessage(response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment Gateway'),
      ),
      body: Column(
        children: [
          RoundButton(
            title: 'Buy',
            onTap: () {
              var options = {
                'key': 'rzp_test_tyxaS4GuEkyx6N',
                'amount': 1 * 100, //in the smallest currency sub-unit.
                'name': 'Acme Corp.', // Generate order_id using Orders API
                'description': 'Fine T-Shirt',
                'timeout': 60, // in seconds
                'prefill': {
                  'contact': '9123456789',
                  'email': 'gaurav.kumar@example.com'
                  
                }
              };
              _razorpay.open(options);
            },
          )
        ],
      ),
    );
  }
}
