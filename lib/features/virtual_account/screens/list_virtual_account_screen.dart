import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/virtual_account/models/list_virtual_account_model.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/popups/loaders.dart';

class TListVirtualAccountScreen extends StatefulWidget {
  @override
  _TListVirtualAccountScreenState createState() =>
      _TListVirtualAccountScreenState();
}

class _TListVirtualAccountScreenState extends State<TListVirtualAccountScreen> {
  late Future<List<TListVirtualAccount>> futureAccounts;

  @override
  void initState() {
    super.initState();
    futureAccounts =
        fetchTListVirtualAccounts(); // Fetch dedicated accounts on initialization
  }

  void _copyToClipboard(String text) {
    try {
      Clipboard.setData(
          ClipboardData(text: text)); // Attempt to copy the text to clipboard

// Show Success Message
      TLoaders.successSnackBar(
          title: 'Hurray', message: '$text copied to clipboard!', duration: 2);
    } catch (e) {
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Failed to copy: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return
        // appBar: AppBar(
        //     title: Text("Virtual Accounts")), // Adding an AppBar for better UX
        FutureBuilder<List<TListVirtualAccount>>(
      future: futureAccounts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return
              //  CircularProgressIndicator()
              TShimmerEffect(
            width: 120,
            height: 20,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final accounts = snapshot.data!;
          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 260,
                  decoration: BoxDecoration(
                      color: dark ? TColors.secondary : TColors.white,
                      border: Border.all(
                        color: dark ? TColors.secondary : TColors.lightGrey,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(
                          'Your NGN Bank Account Details',
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                                color: dark ? TColors.primary : TColors.black,
                              ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //    mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Account Name',
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.apply(
                                        color: dark
                                            ? TColors.primary
                                            : TColors.primary,
                                      ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${account.accountName}, ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                        color: dark
                                            ? TColors.primary
                                            : TColors.black,
                                      ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      _copyToClipboard(account.accountName),
                                  child: Icon(
                                    Icons.copy,
                                    color: TColors.primary,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Account Number',
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.apply(
                                        color: dark
                                            ? TColors.primary
                                            : TColors.primary,
                                      ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${account.accountNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                        color: dark
                                            ? TColors.primary
                                            : TColors.black,
                                      ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      _copyToClipboard(account.accountNumber),
                                  child: Icon(
                                    Icons.copy,
                                    color: TColors.primary,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bank',
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.apply(
                                        color: dark
                                            ? TColors.primary
                                            : TColors.primary,
                                      ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${account.bankName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                        color: dark
                                            ? TColors.primary
                                            : TColors.black,
                                      ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      _copyToClipboard(account.bankName),
                                  child: Icon(
                                    Icons.copy,
                                    color: TColors.primary,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${account.accountBalance}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                    color:
                                        dark ? TColors.primary : TColors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Text('No accounts available.');
        }
      },
    );
  }
}
