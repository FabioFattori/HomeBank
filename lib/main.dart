import 'dart:developer';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeBanking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HomeBanking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum typesOfTransaction { entrata, uscita }

class _MyHomePageState extends State<MyHomePage> {
  
  double MyBankAccount = 0;
  double varTrans = 0;
  typesOfTransaction? type = typesOfTransaction.entrata;

  void TransactionEntry(value) {
    setState(() {
      MyBankAccount += value;
    });
  }

  void TransactionMoneyLeftAcoount(value) {
    setState(() {
      MyBankAccount -= value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.balance),
                    title: Text('il tuo conto $MyBankAccount'),
                  ),
                ])),
            Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.attach_money_rounded),
                      title: Column(
                        children: [
                          ListTile(
                            title: const Text("Entrata"),
                            leading: Radio<typesOfTransaction>(
                              value: typesOfTransaction.entrata,
                              groupValue: type,
                              onChanged: (typesOfTransaction? value) {
                                setState(() {
                                  type = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("Uscita"),
                            leading: Radio<typesOfTransaction>(
                              value: typesOfTransaction.uscita,
                              groupValue: type,
                              onChanged: (typesOfTransaction? value) {
                                setState(() {
                                  type = value;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextField(
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => {
                        if (value != "")
                          {
                            setState(() {
                              varTrans = double.parse(value);
                            }),
                          }
                        else
                          {
                            setState(() {
                              varTrans = 0;
                            }),
                          }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Valore",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () => {
                                if (varTrans > 0)
                                  {
                                    if (type == typesOfTransaction.entrata)
                                      TransactionEntry(varTrans.abs())
                                    else
                                      TransactionMoneyLeftAcoount(
                                          (varTrans.abs()))
                                  }
                              },
                          child: const Text("Crea Transazione")),
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
