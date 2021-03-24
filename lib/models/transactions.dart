import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:susu_gh/services/database.dart';

class SavingsTransaction {
  String agent;
  String customer;
  double amount;
  String transactionType;
  String date;
  String time;

  SavingsTransaction(
      {this.agent,
      this.customer,
      this.amount,
      this.transactionType,
      this.date,
      this.time});

  Map<String, dynamic> savingsJson() => {
        "agent": agent,
        "customer": customer,
        "amount": amount,
        "transaction type": transactionType,
        "date": date,
        "time": time,
      };

  static List<SavingsTransaction> getTransactions(customer) {
    List savingsList = <SavingsTransaction>[];
    savings
        .where('customer', isEqualTo: customer)
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        savingsList.add(SavingsTransaction(
          agent: doc['agent'],
          customer: doc['customer'],
          amount: doc['amount'],
          transactionType: doc['transaction type'],
          date: doc['date'],
          time: doc['time'],
        ));
      });
    });
    return savingsList;
  }

  SavingsTransaction.fromSnapshot(DocumentSnapshot snapshot)
      : agent = snapshot['agent'],
        customer = snapshot['customer'],
        amount = snapshot['amount'],
        transactionType = snapshot['transaction type'],
        date = snapshot['date'],
        time = snapshot['time'];
}

class FDTransaction {
  String agent;
  double rate;
  double amount;
  String date;
  String time;
  String customer;
}
