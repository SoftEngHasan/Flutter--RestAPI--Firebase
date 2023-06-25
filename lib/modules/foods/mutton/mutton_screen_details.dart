import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../customer_module/customer_checkout/CustomerCheckoutScreen.dart';
import '../../customer_module/customer_checkout/cart_screen.dart';
import '../../widgets/app_elevated_button.dart';

class MuttonScreenDetails extends StatefulWidget {
  final String? title, url, price, email;

  const MuttonScreenDetails({
    Key? key,
    required this.title,
    required this.price,
    required this.url,
    this.email,
  }) : super(key: key);

  @override
  State<MuttonScreenDetails> createState() => _MuttonScreenDetailsState();
}

class _MuttonScreenDetailsState extends State<MuttonScreenDetails> {
  Future addDetailsToDatabase() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure for submission?'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection(widget.email.toString())
                      .add({
                    'title': widget.title.toString(),
                    'price': widget.price.toString(),
                    'image': widget.url.toString()
                  });

                  Get.showSnackbar(
                    const GetSnackBar(
                      title: 'Successfully added!',
                      message: ' ',
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Get.to(CartScreen(
                    title: widget.title.toString(),
                    price: widget.price.toString(),
                    imageUrl: widget.url.toString(),
                    email: widget.email.toString(),
                  ));
                },
                child: const Text('Yes')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.withOpacity(0.4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    widget.url.toString(),
                    width: double.infinity,
                  ),
                ),
                Text(
                  widget.title.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Total Price : ${widget.price.toString()}',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    text: 'Add to Cart',
                    onTap: () {
                      addDetailsToDatabase();
                    },
                  ),
                ),
                const SizedBox(
                  height: 130,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
