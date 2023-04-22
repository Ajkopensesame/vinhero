import 'package:cloud_firestore/cloud_firestore.dart';

class ProblemService {
  Future<bool> submitCauseAndCorrection(
      String make, String model, String year, String vin, String concern, String cause, String correction) async {
    try {
      final problemsRef = FirebaseFirestore.instance
          .collection('problems')
          .doc(make)
          .collection(model)
          .doc(year)
          .collection('problems');

      await problemsRef
          .doc(concern)
          .collection('fixes')
          .add({
        'cause': cause,
        'correction': correction,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Increment the problem count
      await problemsRef
          .doc(concern)
          .set({'count': FieldValue.increment(1)}, SetOptions(merge: true));

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
  Future<List<Map<String, dynamic>>> getFixesForProblem(String make, String model, String year, String problem) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('problems')
        .doc(make)
        .collection(model)
        .doc(year)
        .collection('problems')
        .doc(problem)
        .collection('fixes')
        .get();

    return snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'cause': doc.data()['cause'],
        'correction': doc.data()['correction'],
        'timestamp': doc.data()['timestamp'],
      };
    }).toList();
  }


  Future<List<Map<String, dynamic>>> getTopCommonProblems(String make, String model, int year) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('problems')
        .doc(make)
        .collection(model)
        .doc(year.toString())
        .collection('problems')
        .orderBy('count', descending: true)

        .limit(5)
        .get();

    return snapshot.docs.map((doc) {
      return {
        'problem': doc.id,
        'count': doc.data()['count'],
        'year': year,
      };
    }).toList();
  }

  Stream<List<Map<String, dynamic>>> getTopCommonProblemsStream(String make, String model, int year) {
    return FirebaseFirestore.instance
        .collection('problems')
        .doc(make)
        .collection(model)
        .doc(year.toString())
        .collection('problems')
        .orderBy('count', descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'problem': doc.id,
          'count': doc.data()['count'],
          'year': year,
        };
      }).toList();
    });
  }
}
