import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';
import '../models/transaction.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Records'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implement search functionality
                // You can use a text field and filter the records based on user input
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: _buildRecordsList(controller.transactions)),
          ],
        ),
      );
    });
  }

  Widget _buildRecordsList(List<TransactionModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(child: Text('No records available.'));
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

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Filter by Date'),
                  const SizedBox(height: 8.0),
                  _buildFilterOptions(),
                  const SizedBox(height: 8.0),
                  // _buildDateRangePicker(setState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterOptions() {
    return Wrap(
      spacing: 5.0,
      children: [
        _buildFilterChip('1D'),
        _buildFilterChip('1M'),
        _buildFilterChip('1Q'),
        _buildFilterChip('1Y'),
        _buildFilterChip('All'),
      ],
    );
  }

  Widget _buildFilterChip(String filter) {
    return Obx(() => FilterChip(
          label: Text(filter),
          selected: controller.selectedFilter.value.toLowerCase() ==
              filter.toLowerCase(),
          onSelected: (bool selected) {
            controller.selectedFilter.value = selected ? filter : '';

            if (kDebugMode) {
              print(controller.selectedFilter.value);
            }
          },
          selectedColor: Colors.blue,
          labelStyle: TextStyle(
            color: controller.selectedFilter.value == filter
                ? Colors.white
                : Colors.black,
          ),
        ));
  }
}
