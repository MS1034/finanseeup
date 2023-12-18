import 'package:finanseeup/controllers/transaction_controller.dart';
import 'package:finanseeup/widgets/transaction_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';

class RecordView extends StatefulWidget {
  final int initialTabNumber;

  const RecordView({super.key, required this.initialTabNumber});

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> with TickerProviderStateMixin {
  String text = "";
  late TabController _tabController = TabController(
      length: 3, vsync: this, initialIndex: widget.initialTabNumber - 1);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initialTabNumber - 1);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close), // Tick icon
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check), // Cross icon
            onPressed: () {
              controller.addTransaction(_tabController.index+1);
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: "Income"),
            Tab(text: "Expense"),
            Tab(text: "Transfer"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(

              controller: _tabController,
              children: const [
                Center(
                    child: RecordContainer(
                      number: 1,
                    )),
                Center(
                    child: RecordContainer(
                      number: 2,
                    )),
                Center(
                    child: RecordContainer(
                      number: 3,
                    )),
              ],
            ),
          ),
          NumericKeyboard(
            onKeyboardTap: onKeyboardTap,
            textStyle: Theme
                .of(context)
                .textTheme
                .titleLarge!,
            rightButtonFn: onKeyboardEraseOne,
            rightButtonLongPressFn: onKeyboardEraseAll,

            rightIcon: const Icon(
              Icons.backspace_outlined,
              color: Colors.blueGrey,
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      )
      ,
    );
  }

  void onKeyboardTap(String value) {
    final controller = TransactionController.instance;

    setState(() {
      text = text + value;
      if (kDebugMode) {
        print(text);
      }
    });

    // Update the amount in the controller
    controller.updateAmount(double.parse(text));
  }

  void onKeyboardEraseOne() {
    final controller = TransactionController.instance;

    if (text.isNotEmpty) {
      setState(() {
        text = text.substring(0, text.length - 1);
      });
      if (text.isNotEmpty) {
        print(text);

        controller.updateAmount(double.parse(text));
      } else {
        controller.updateAmount(double.parse("0"));
      }
    }
  }


  void onKeyboardEraseAll() {
    final controller = TransactionController.instance;

    if (text.isNotEmpty) {
      setState(() {
        text = '';
      });
      if (text.isNotEmpty) {
        print("object");
        controller.updateAmount(double.parse(text));
      } else {
        controller.updateAmount(double.parse("0"));
      }
    }
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
