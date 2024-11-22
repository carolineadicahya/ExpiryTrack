import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expiry_track/screen/add_product.dart';

class ProductService {
  final db = FirebaseFirestore.instance.collection('product');

  // GET ALL
  Stream<QuerySnapshot> getData() {
    final dataStream = db.orderBy('name', descending: false).snapshots();
    return dataStream;
  }

  // GET by ID
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDetail(String id) {
    final dataStream = db.doc(id).snapshots();
    return dataStream.map(
      (snapshot) => snapshot as DocumentSnapshot<Map<String, dynamic>>,
    );
  }

  // ADD
  Future<String> addProduct(Map<String, dynamic> body) async {
    var result = await db.add(body);
    return result.id;
  }

  // UPDATE
  Future<void> updateProduct(String id, Map<String, dynamic> body) async {
    return db.doc(id).update(body);
  }

  // DELETE
  Future<void> deleteProduct(String id) {
    return db.doc(id).delete();
  }

  Future<void> updateNewExpired(String id, DateTime newExpired) async {
    await db.doc(id).update({'Kadaluarsa Baru': newExpired});
  }
}
