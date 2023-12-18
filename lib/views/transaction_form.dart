import 'package:finanseeup/controllers/transaction_controller.dart';
import 'package:finanseeup/models/label.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:finanseeup/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../models/enum_payment_type.dart';
import '../utils/consts/sizes.dart';
import '../widgets/color_picker.dart';

class TransactionFormView extends StatelessWidget {
  final TransactionController controller;
  final int number;

  // Constructor for TransactionFormView
  const TransactionFormView(
      {super.key, required this.controller, required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              controller.addTransaction(number + 1);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              PaymentTypeField(controller: controller),
              PayeeField(controller: controller),
              DateTimeFields(controller: controller),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 0.75 * AppHelperFunctions.screenWidth(),
                    child: MultiSelectLabelsField(controller: controller),
                  ),
                  AddLabelButton(controller: controller),
                ],
              ),
              DescriptionField(controller: controller),
              const SizedBox(
                height: AppSizes.defaultSpace,
              ),
              AppImagePicker(
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentTypeField extends StatelessWidget {
  final TransactionController controller;

  const PaymentTypeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.paymentTypeController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Payment Type',
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => {_showPopup(controller)},
        ),
      ),
    );
  }

  void _showPopup(TransactionController controller) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: PaymentType.values.map((paymentType) {
              return ListTile(
                title: Text(paymentType.name),
                onTap: () {
                  controller.paymentTypeController.text = paymentType.name;
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PayeeField extends StatelessWidget {
  final TransactionController controller;

  const PayeeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.payeeController,
      decoration: const InputDecoration(
        labelText: 'Payee',
      ),
    );
  }
}

class DateTimeFields extends StatelessWidget {
  final TransactionController controller;

  const DateTimeFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => _selectDate(context, controller),
          child: IgnorePointer(
            child: TextFormField(
              controller: controller.dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => _selectTime(context, controller),
          child: IgnorePointer(
            child: TextFormField(
              controller: controller.timeController,
              decoration: const InputDecoration(
                labelText: 'Time',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, TransactionController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != controller.selectedDate) {
      controller.selectedDate.value = picked;
      controller.dateController.text =
          picked.toLocal().toString().split(' ')[0];
      controller.addDate(picked);
    }
  }

  Future<void> _selectTime(
      BuildContext context, TransactionController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != controller.selectedTime) {
      controller.selectedTime.value = picked;
      controller.timeController.text = picked.format(context);
      controller.addTime(picked);
    }
  }
}

class MultiSelectLabelsField extends StatelessWidget {
  final TransactionController controller;

  const MultiSelectLabelsField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MultiSelectBottomSheetField(
        buttonIcon: const Icon(Icons.arrow_drop_down),
        initialChildSize: 0.4,
        listType: MultiSelectListType.CHIP,
        searchable: true,
        buttonText: const Text("Favorite Labels"),
        title: const Text("Labels"),
        items: controller.getLabels,
        onConfirm: (values) {
          controller.selectedLabels.assignAll(values.cast<String>());
        },
        chipDisplay: MultiSelectChipDisplay(
          onTap: (value) {
            controller.selectedLabels.remove(value);
          },
        ),
      ),
    );
  }
}

class AddLabelButton extends StatelessWidget {
  final TransactionController controller;

  const AddLabelButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {_showPopupAddLabel(controller)},
      icon: const Icon(Icons.add),
    );
  }

  void _showPopupAddLabel(TransactionController controller) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.labelController,
                decoration: const InputDecoration(labelText: 'Enter Label'),
              ),
              const SizedBox(height: 16.0),
              ColorPickerField(
                controller: controller,
                initialText: '',
              ),
              const SizedBox(height: 16.0),
              // OutlinedButton(
              //   onPressed: () {
              //     _showColorPicker(controller);
              //   },
              //   child: const Text('Pick Color'),
              // ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  _addToLabelList(controller);
                },
                child: const Text('Add to List'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }

  void _showColorPicker(TransactionController controller) {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Colors.red, // You can use your own default color
              onColorChanged: (Color color) {
                controller.labelColors.assignAll([color]);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addToLabelList(TransactionController controller) {
    String enteredLabel = controller.labelController.text.trim();
    if (enteredLabel.isNotEmpty) {
      controller.addLabel(LabelModel(name: enteredLabel));
      controller.labelController.clear();
    }
  }
}

class DescriptionField extends StatelessWidget {
  final TransactionController controller;

  const DescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.descriptionController,
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: 'Description',
      ),
    );
  }
}
