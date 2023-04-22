import 'package:flutter/material.dart';

class CodeSearch extends SearchDelegate<Map<String, dynamic>> {
  final List<Map<String, dynamic>> codes;

  CodeSearch(this.codes);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, <String, dynamic>{});
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> suggestions = query.isEmpty
        ? []
        : codes.where((code) {
      return code['Code'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            close(context, suggestions[index]);
          },
          title: Text(suggestions[index]['Code']),
          subtitle: Text(suggestions[index]['Description']),
        );
      },
    );
  }
}
