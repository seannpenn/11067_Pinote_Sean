import 'package:elec2b_review/safe_cracker_widgets/safe_dial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elec2b_review/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Review App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartScreen(),
    );
  }
}

class SafeCrackerView extends StatefulWidget {
  const SafeCrackerView({Key? key}) : super(key: key);

  @override
  State<SafeCrackerView> createState() => _SafeCrackerViewState();
}

class _SafeCrackerViewState extends State<SafeCrackerView> {
  List<int> values = [0, 0, 0];
  String feedback = "";
  String combination = "451";
  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text("Safe Cracker"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isUnlocked
                  ? CupertinoIcons.lock_open_fill
                  : CupertinoIcons.lock_fill,
              size: 128,
              color: isUnlocked? Colors.greenAccent: Colors.redAccent,
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < values.length; i++)
                    SafeDial(
                        startingValue: values[i],
                        onIncrement: () {
                          setState(() {
                            values[i]++;
                            if(values[i] > 9) {
                              values[i] = 9;
                            }
                          });
                        },
                        onDecrement: () {
                          setState(() {
                            values[i]--;
                            if(values[i] < 0){
                              values[i] = 0;
                            }
                          });
                        }),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 0,bottom: 30),
                child: TextButton(
                  onPressed: () {
                    resetNumbers(values);
                  },
                  child: const Text(
                    "reset",
                    style: TextStyle(color: Colors.grey),
                  ),
                )),
            if (feedback.isNotEmpty) Text(feedback),
            Container(
              margin: const EdgeInsets.only(top:48),
              child: TextButton(
                  onPressed: () {
                    unlockSafe();
                  },
                  child: Container(
                      color: Colors.greenAccent,
                      padding: const EdgeInsets.all(25),
                      child: const Text("Open the safe"))),
            ),
            TextButton(
                onPressed: () {
                  lockSafe(values);
                },
                child: Container(
                    margin: const EdgeInsets.only(top:20),
                    color: Colors.redAccent,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Lock safe"))),
            // const Text("This is the total of all the values"),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       values = [0, 0, 0];
            //     });
            //   },
            //   child: NumberHolder(
            //     content: sumofAllValues(values),
            //   ),
            // ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  unlockSafe() {
    if (checkCombination()) {
      setState(() {
        resetNumbers(values);
        isUnlocked = true;
        feedback = "You unlocked the safe";
      });
    } else {
      setState(() {
        isUnlocked = false;
        feedback = "Wrong combination, try again";
      });
    }
  }

  lockSafe(List<int> val) {
    setState(() {
      for (int i = 0; i < values.length; i++){
        values[i] = 0;
      }
      isUnlocked = false;
      feedback = "Safe locked";
    });
    
  }

  resetNumbers(List<int> val){
    setState(() {
      for (int i = 0; i < values.length; i++){
        values[i] = 0;
      }
    });
  }

  bool checkCombination() {
    String theCurrentValue = convertValuesToComparableString(values);
    bool isUnlocked = (theCurrentValue == combination);
    // print(convertValuesToComparableString(values));
    print(isUnlocked);
    return isUnlocked;
  }
}

String convertValuesToComparableString(List<int> val) {
  String temp = "";
  for (int v in val) {
    temp += "$v";
  }
  return temp;
}

int sumofAllValues(List<int> list) {
  int temp = 0;

  for (int number in list) {
    temp += number;
  }
  return temp;
}

class NumberHolder extends StatelessWidget {
  final dynamic content;
  const NumberHolder({Key? key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minHeight: 60),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Center(
        child: Text(
          "$content",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class IncrementalNumberHolder extends StatefulWidget {
  final Function(int)? onUpdate;
  final int startingValue;
  const IncrementalNumberHolder(
      {Key? key, this.startingValue = 0, required this.onUpdate})
      : super(key: key);

  @override
  State<IncrementalNumberHolder> createState() =>
      _IncrementalNumberHolderState();
}

class _IncrementalNumberHolderState extends State<IncrementalNumberHolder> {
  @override
  void initState() {
    currentValue = widget.startingValue;
    super.initState();
  }

  late int currentValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minHeight: 60),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                currentValue--;
              });
              widget.onUpdate!(currentValue);
            },
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
              child: Text(
            "$currentValue",
            textAlign: TextAlign.center,
          )),
          IconButton(
            onPressed: () {
              setState(() {
                currentValue++;
              });
              widget.onUpdate!(currentValue);
            },
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
