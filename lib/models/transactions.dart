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
  String transactionType;
  double rate;
  double amount;
  String date;
  String time;
  String customer;

  FDTransaction(
      {this.agent,
      this.rate,
      this.amount,
      this.transactionType,
      this.date,
      this.time,
      this.customer});

  Map<String, dynamic> fdJson() => {
        "agent": agent,
        "rate": rate,
        "transaction type": transactionType,
        "amount": amount,
        "date": date,
        "time": time,
        "customer": customer,
      };

  static List<FDTransaction> getTransactions(customer) {
    List fdList = <FDTransaction>[];
    fdList
        .where('customer', equal: customer)
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        fdList.add(FDTransaction(
          agent: doc['agent'],
          rate: doc['rate'],
          transactionType: doc['transaction type'],
          amount: doc['amount'],
          customer: doc['customer'],
          date: doc['date'],
          time: doc['time'],
        ));
      });
    });
    return fdList;
  }

  FDTransaction.fromSnapshot(DocumentSnapshot snapshot)
      : agent = snapshot['agent'],
        customer = snapshot['customer'],
        amount = snapshot['amount'],
        rate = snapshot['rate'],
        date = snapshot['date'],
        time = snapshot['time'];
}
