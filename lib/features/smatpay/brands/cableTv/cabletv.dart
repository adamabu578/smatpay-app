import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/cable_tv_controller.dart';
import '../../models/cable_plan_model.dart';

class TCableTvScreen extends StatelessWidget {
  TCableTvScreen({Key? key}) : super(key: key);

  final CableTvController controller = Get.put(CableTvController());
  final List<String> providers = ['dstv', 'gotv', 'startimes'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final textColor = dark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: Text("Cable TV", style: TextStyle(color: textColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Provider Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Select Provider",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: dark ? Colors.grey[800] : Colors.white,
                ),
                value: controller.selectedProvider.value.isNotEmpty
                    ? controller.selectedProvider.value
                    : null,
                items: providers.map((provider) {
                  return DropdownMenuItem(
                    value: provider,
                    child: Text(provider.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedProvider.value = value!;
                  controller.plans.clear();
                  controller.customerDetails.value = null;
                },
                validator: (value) => value == null ? 'Required' : null,
              ),
              SizedBox(height: 20),

              // Smartcard Number Field
              TextFormField(
                controller: controller.smartcardController,
                decoration: InputDecoration(
                  labelText: 'Smartcard Number',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: dark ? Colors.grey[800] : Colors.white,
                  suffixIcon: Obx(() => controller.isVerifying.value
                      ? CircularProgressIndicator()
                      : IconButton(
                    icon: Icon(Icons.verified_user),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final verified = await controller.verifySmartcard();
                        if (verified) {
                          await controller.fetchPlans();
                        }
                      }
                    },
                  )),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 16),

              // Error Message
              Obx(() => controller.errorMessage.isNotEmpty
                  ? Text(
                controller.errorMessage.value,
                style: TextStyle(color: Colors.red),
              )
                  : SizedBox()),

              // Customer Details
              Obx(() => controller.customerDetails.value != null
                  ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Name: ${controller.customerDetails.value!.customerName}'),
                      Text('Status: ${controller.customerDetails.value!.status}'),
                      Text('Current Bouquet: ${controller.customerDetails.value!.currentBouquet}'),
                      Text('Due Date: ${controller.customerDetails.value!.dueDate}'),
                    ],
                  ),
                ),
              )
                  : SizedBox()),

              SizedBox(height: 16),

              // Plans List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.plans.isNotEmpty) {
                    return ListView.builder(
                      itemCount: controller.plans.length,
                      itemBuilder: (context, index) {
                        final plan = controller.plans[index];
                        return Card(
                          child: RadioListTile<CablePlan>(
                            title: Text(plan.name),
                            subtitle: Text('₦${plan.amount.toStringAsFixed(2)}'),
                            value: plan,
                            groupValue: controller.selectedPlan.value,
                            onChanged: (value) {
                              controller.selectedPlan.value = value;
                              controller.amount.value = value?.amount.toStringAsFixed(2) ?? '';
                            },
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: Text('Select provider and verify smartcard'));
                }),
              ),

              // Proceed Button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        controller.selectedPlan.value != null) {
                      // Process payment
                    }
                  },
                  child: Text(
                    'PAY ₦${controller.amount.value}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}