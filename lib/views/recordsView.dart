import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';
import '../models/transaction.dart';

class RecordsView extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
              // You can use a text field and filter the records based on user input
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterDropdown(),
          Expanded(
            child: Obx(() {
              return _buildRecordsList(controller.transactions);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('Filter:'),
          SizedBox(width: 10),
          // DropdownButton<String>(
          //   value: controller.SelectedFilter.value,
          //   items: [
          //     DropdownMenuItem(
          //       value: 'all',
          //       child: Text('All Time'),
          //     ),
          //     DropdownMenuItem(
          //       value: 'year',
          //       child: Text('Year'),
          //     ),
          //     DropdownMenuItem(
          //       value: 'quarter',
          //       child: Text('Quarter'),
          //     ),
          //     DropdownMenuItem(
          //       value: 'lastMonth',
          //       child: Text('Last Month'),
          //     ),
          //   ],
          //   onChanged: (value) {
          //     controller.selectedFilter.value = value!;
          //     // Implement logic to filter records based on the selected filter
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildRecordsList(List<TransactionModel> transactions) {
    if (transactions.isEmpty) {
      return Center(child: Text('No records available.'));
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        TransactionModel transaction = transactions[index];
        return ListTile(
          title: Text('Amount: ${transaction.amount}'),
          subtitle: Text('Description: ${transaction.description}'),
          // Add more details or customize the ListTile as needed
        );
      },
    );
  }
}
