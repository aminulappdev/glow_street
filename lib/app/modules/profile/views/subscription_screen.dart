import 'package:flutter/material.dart';
import 'package:glow_street/app/utils/responsive_size.dart';
import 'package:glow_street/app/widgets/costom_app_bar.dart';
import 'package:glow_street/app/widgets/costum_elavated_button.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox30,
            CustomAppBar(name: 'Subscription'),
            heightBox30,
            Card(
              elevation: 1,
              color: Color(0xffE6E6E6),
              child: Container(
                height: 65,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Current Plan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      heightBox4,
                      Text(
                        'Monthly - 12 Day remaining',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 87, 87, 87),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            heightBox12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose a plan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                heightBox4,
                Text(
                  'Monthly or yearly?It’s your call',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 87, 87, 87),
                  ),
                )
              ],
            ),
            heightBox12,
            package('Monhthly', '100'),
            heightBox12,
            package('Yearly', '100'),
            heightBox14,
            CustomElevatedButton(title: 'Go to Payment')
          ],
        ),
      ),
    );
  }

  Container package(String package, String price) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Color.fromARGB(255, 255, 253, 253),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  package,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                heightBox4,
                Row(
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 4, 4, 4),
                      ),
                    ),
                    Text(
                      '/month',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 87, 87, 87),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Checkbox(
              value: false,
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
