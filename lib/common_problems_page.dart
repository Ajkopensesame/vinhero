import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vinhero/problem_fix_form_page.dart';
import 'package:vinhero/services/error_code_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'known_fixes_page.dart';

class CommonProblemsPage extends StatefulWidget {
  final String make;
  final String model;
  final String year;
  final String vin;


  const CommonProblemsPage({
    Key? key,
    required this.make,
    required this.model,
    required this.year,

    required this.vin, required engine,
  }) : super(key: key);

  @override
  _CommonProblemsPageState createState() => _CommonProblemsPageState();
}

class _CommonProblemsPageState extends State<CommonProblemsPage> {
  List<Map<String, dynamic>> _errorCodes = [];
  List<Map<String, dynamic>> _searchResults = [];
  String _searchQuery = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _errorCodeService = ErrorCodeService();
  TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _loadErrorCodes();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _loadErrorCodes() async {
    List<dynamic> errorCodes = await _errorCodeService.getErrorCodes();
    setState(() {
      _errorCodes = errorCodes.cast<Map<String, dynamic>>();
    });
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _searchProblems(_searchController.text);
    });
  }

  void _searchProblems(String query) {
    List<Map<String, dynamic>> results = [];

    if (query.isNotEmpty) {
      for (var errorCode in _errorCodes) {
        if (errorCode['code'].toLowerCase().contains(query.toLowerCase()) ||
            errorCode['description'].toLowerCase().contains(
                query.toLowerCase())) {
          results.add(errorCode);
        }
      }
    }

    setState(() {
      _searchQuery = query;
      _searchResults = results;
    });
  }

  Future<void> updateClickCount(String errorCode, int count) async {
    await _firestore.collection('errorCodes').doc(errorCode).update({
      'clickCount': FieldValue.increment(1),
    }).catchError((error) {
      if (error is FirebaseException && error.code == 'not-found') {
        _firestore.collection('errorCodes').doc(errorCode).set({
          'clickCount': 1,
        });
      } else {
        throw error;
      }
    });
  }

  void _incrementClickCount(String errorCode) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('errorCodes')
        .doc(errorCode)
        .get();

    int currentCount = docSnapshot.exists ? docSnapshot['clickCount'] ?? 0 : 0;
    int newCount = currentCount + 1;

    await updateClickCount(errorCode, newCount);

    setState(() {
      for (var errorCodeEntry in _errorCodes) {

        if (errorCodeEntry['code'] == errorCode) {
          errorCodeEntry['clickCount'] = newCount;
        }
      }
      for (var errorCodeEntry in _searchResults) {
        if (errorCodeEntry['code'] == errorCode) {
          errorCodeEntry['clickCount'] = newCount;
        }
      }
    });
  }

  Widget _buildListItem(BuildContext context, Map<String, dynamic> item) {
    List<String> possibleCauses = List<String>.from(item['possible_causes'] ?? []);
    int clickCount = item['clickCount'] ?? 0;
    return ListTile(
      onTap: () {
        _incrementClickCount(item['code']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnownFixesPage(
              make: widget.make,
              model: widget.model,
              year: widget.year,
              code: item['code'],
              description: item['description'],
              possibleCauses: possibleCauses,
            ),
          ),
        );
      },
      title: Text(
        item['code'],
        style: TextStyle(fontSize: 14),
      ),
      subtitle: Text(item['description']),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.year}'),
          Text('Clicks: $clickCount'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Common Problems'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for problems...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _searchQuery.isEmpty
                ? _errorCodes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _errorCodes.length,
              itemBuilder: (context, index) {
                return _buildListItem(context, _errorCodes[index]);
              },
            )
                : _searchResults.isEmpty
                ? Center(
              child: Text('No results found for "$_searchQuery"'),
            )
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return _buildListItem(context, _searchResults[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProblemFixFormPage(
                make: widget.make,
                model: widget.model,
                year: widget.year,
                vin: widget.vin,
                onSubmitProblem: (String) {},
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}