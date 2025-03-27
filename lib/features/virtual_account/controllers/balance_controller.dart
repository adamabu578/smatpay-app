import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BalanceController extends GetxController {
  var balance = 0.0.obs; // Observable balance

  // Fetch the user's account balance from Firestore
  Future<void> fetchAccountBalance() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('PaystackUsers')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        // Cast the data to Map<String, dynamic>
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        balance.value =
            data['accountBalance'] ?? 0.0; // Update observable balance
      } else {
        balance.value = 0.0; // Default value if document does not exist
      }
    } catch (e) {
      print('Error fetching balance: $e');
      balance.value = 0.0; // Return 0 in case of an error
    }
  }

  // Update the user's account balance in Firestore
  Future<void> updateBalance(double newBalance) async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('PaystackUsers')
          .doc(userId)
          .update({'accountBalance': newBalance});
      balance.value = newBalance; // Update the observable balance
      print('Balance updated successfully in Firestore.');
    } catch (e) {
      print('Error updating balance in Firestore: $e');
    }
  }
}
