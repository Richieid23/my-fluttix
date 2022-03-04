part of 'services.dart';

class FlutixTransactionServices {
  static CollectionReference transactionCollection =
      Firestore.instance.collection('transactions');

  static Future<void> saveTransaction(
      FlutixTransaction flutixTransaction) async {
    await transactionCollection.document().setData({
      'userId': flutixTransaction.userId,
      'title': flutixTransaction.title,
      'subtitle': flutixTransaction.subtitle,
      'time': flutixTransaction.time.millisecondsSinceEpoch,
      'amount': flutixTransaction.amount,
      'picture': flutixTransaction.picture,
    });
  }

  static Future<List<FlutixTransaction>> getTransaction(String userId) async {
    QuerySnapshot snapshot = await transactionCollection.getDocuments();

    var documents = snapshot.documents
        .where((document) => document.data['userId'] == userId);

    return documents
        .map((e) => FlutixTransaction(
              userId: e.data['userId'],
              title: e.data['title'],
              subtitle: e.data['subtitle'],
              time: DateTime.fromMillisecondsSinceEpoch(e.data['time']),
              amount: e.data['amount'],
              picture: e.data['picture'],
            ))
        .toList();
  }
}
