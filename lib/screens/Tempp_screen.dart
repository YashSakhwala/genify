import "package:flutter/material.dart";
import "package:genify/controller/transaction_controller.dart";
import "package:get/get.dart";

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  Map dateWiseData = {};

  @override
  Widget build(BuildContext context) {
    for (var entry in transactionController.combinedList) {
      String date = entry['date'];
      if (!dateWiseData.containsKey(date)) {
        dateWiseData[date] = [];
      }
      dateWiseData[date]!.add(entry);
    }

    List dateEntries = dateWiseData.entries.toList();

    return Scaffold(
      body: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dateEntries.length,
            itemBuilder: (context, index) {
              String date = dateEntries[index].key;
              List entries = dateEntries[index].value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: entries.length,
                    itemBuilder: (context, entryIndex) {
                      var entry = entries[entryIndex];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Container(
                          height: 89,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17, vertical: 14),
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.blue,
                                      strokeWidth: 2,
                                    ),
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.blue),
                                        image: DecorationImage(
                                          image: Image.network(entry['image'])
                                              .image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry['title'],
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        entry['subTitle'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${entry['type'] == 'Income' ? '+' : '-'} ₹${entry['amount']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: entry['type'] == 'Income'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        entry['time'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
