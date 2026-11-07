import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerbBankScreen extends StatefulWidget {
  const VerbBankScreen({super.key});

  @override
  State<VerbBankScreen> createState() => _VerbBankScreenState();
}

class _VerbBankScreenState extends State<VerbBankScreen> {
  List<dynamic> verbs = [];
  List<dynamic> filteredVerbs = [];
  bool isLoading = true;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    loadVerbs();
  }

  Future<void> loadVerbs() async {
    try {
      final String data =
          await rootBundle.loadString('assets/data/verbs_sample.json');

      final List<dynamic> loadedVerbs = jsonDecode(data);

      setState(() {
        verbs = loadedVerbs;
        filteredVerbs = loadedVerbs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchVerbs(String query) {
    setState(() {
      searchText = query.toLowerCase();

      filteredVerbs = verbs.where((verb) {
        return verb['v1'].toString().toLowerCase().contains(searchText) ||
            verb['hindi'].toString().contains(searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Verb Bank'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: searchVerbs,
              decoration: InputDecoration(
                hintText: 'Search English or Hindi verb...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Verbs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${filteredVerbs.length} verbs'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredVerbs.isEmpty
                    ? const Center(child: Text('No verbs found'))
                    : ListView.builder(
                        itemCount: filteredVerbs.length,
                        itemBuilder: (context, index) {
                          final verb = filteredVerbs[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${verb['v1']} — ${verb['hindi']}',
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(),
                                  Text('V1: ${verb['v1']}'),
                                  Text('V2: ${verb['v2']}'),
                                  Text('V3: ${verb['v3']}'),
                                  Text('V-ing: ${verb['ving']}'),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Example: ${verb['example']}',
                                    style: const TextStyle(
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
