import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'customListTile.dart';

class ViewAllCoins extends StatefulWidget {
  const ViewAllCoins({super.key});

  @override
  _ViewAllCoinsState createState() => _ViewAllCoinsState();
}

class _ViewAllCoinsState extends State<ViewAllCoins> {
  late WebSocketChannel channel;
  List<Map<String, dynamic>> tickerData = [];
  List<Map<String, dynamic>> filteredTickerData = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    channel = WebSocketChannel.connect(
      Uri.parse('ws://prereg.ex.api.ampiy.com/prices'),
    );

    channel.sink.add(jsonEncode({
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1,
    }));

    channel.stream.listen(
      (data) {
        try {
          final decodedData = jsonDecode(data);

          if (decodedData['stream'] == "all@fpTckr") {
            setState(() {
              tickerData =
                  List<Map<String, dynamic>>.from(decodedData['data'] ?? []);
              _filterData();
            });
          }
        } catch (e) {
          print("Error decoding data: $e");
        }
      },
      onError: (error) {
        print("WebSocket error: $error");
      },
    );

    _searchController.addListener(_filterData);
  }

  void _filterData() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      filteredTickerData = tickerData.where((item) {
        final tickerName = item['s']?.toString().toLowerCase() ?? '';
        return tickerName.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    channel.sink.close(1000);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COINS'),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: tickerData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : filteredTickerData.isEmpty
                    ? Center(child: Text('No matching results found...'))
                    : ListView.builder(
                        itemCount: filteredTickerData.length,
                        itemBuilder: (context, index) {
                          final item = filteredTickerData[index];
                          Color color = (index + 1) % 2 == 1
                              ? Colors.white
                              : Colors.white10;

                          return CustomListTile(item: item, color: color);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
