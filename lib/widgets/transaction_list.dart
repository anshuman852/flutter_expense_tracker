import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTx;

  TransactionList(this.userTransaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    "No Transaction Yet",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Image.asset(
                    "image/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, int i) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: GestureDetector(
                  onPanUpdate: (tx) {
                    if (tx.delta.dx > 0) {
                      deleteTx(userTransaction[i].id);
                    }
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${userTransaction[i].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransaction[i].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(userTransaction[i].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 450 ? FlatButton.icon(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteTx(userTransaction[i].id),
                      label: const Text("Delete"),
                      textColor: Theme.of(context).errorColor,
                    ) : IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(userTransaction[i].id),
                    ),
                  ),
                ),
              );
            },
            itemCount: userTransaction.length,
          );
  }
}
