import 'dart:convert';
import 'package:ampiy_ui/utils/app_color/colors.dart';
import 'package:ampiy_ui/views/widget/line_graph.dart';
import 'package:ampiy_ui/views/widget/view_coins.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../controllers/percentage.dart';
import 'widget/horizontal_graph.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebSocketChannel channel;
  List<Map<String, dynamic>> tickerData = [];

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
  }

  @override
  void dispose() {
    channel.sink.close(1000);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSIPSection(),
            _buildInfoCards(),
            _buildCoinsList(),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ViewAllCoins();
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor().darkCharcoal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 140, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "View all",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            GraphBar(item: tickerData),
            GraphHorizontalBar(
              item: tickerData,
            ),
            _buildHotCoinsDataDisplay(),
            _buildZones(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 5, right: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topRight,
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Column(
              children: const [
                Text(
                  "Welcome to AMPIY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Buy your first Crypto Asset today",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: ElevatedButton(
                child: const Text(
                  "Verify Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor().brightBlue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureIcon(
                  Icons.add_circle,
                  "Buy",
                ),
                _buildFeatureIcon(Icons.remove_circle_outlined, "Sell"),
                _buildFeatureIcon(Icons.person, "Referral"),
                _buildFeatureIcon(Icons.video_collection_outlined, "Tutorial"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSIPSection() {
    return Container(
      color: AppColor().darkCharcoal,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create Wealth with SIP",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Invest. Grow. Repeat. Grow your money with SIP now.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {},
                  label: const Text(
                    "Start a SIP",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    backgroundColor: AppColor().brightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            "asset/images/homepagelogo.png",
            width: 80,
            height: 100,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          _buildInfoCard("SIP Calculator", "Calculate Interests and Return",
              Icons.calculate),
          _buildInfoCard(
              "Deposit INR",
              "Use UPI or Bank Account to trade or buy SIP",
              Icons.account_balance),
        ],
      ),
    );
  }

  Widget _buildCoinsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10,left: 10),
          child: Text(
            'Coins',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: tickerData.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tickerData.length > 10 ? 10 : tickerData.length,
                  itemBuilder: (context, index) {
                    final item = tickerData[index];
                    final coinName =
                        item['s']?.substring(0, item['s']?.length ~/ 2) ?? '';
                    final price = item['c'] ?? '0.0';
                    final percentageChange = formatPercentage(item['P']);
                    final isNegative = (item['P'] ?? '').startsWith('-');

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text("${coinName[0]}"),
                        backgroundColor: AppColor().brightBlue,
                      ),
                      title: Text(
                        item['s'] ?? '',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        coinName,
                        style: const TextStyle(color: Colors.white54),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹ $price',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '₹ ${item['p'] ?? ''}',
                                style: TextStyle(
                                  color: isNegative ? Colors.red : Colors.green,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                color: isNegative
                                    ? AppColor().darkMaroon
                                    : AppColor().darkGreen,
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  child: Text(
                                    percentageChange,
                                    style: TextStyle(
                                      color: isNegative
                                          ? Colors.red
                                          : Colors.green,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }

  Widget _buildHotCoinsDataDisplay() {
    return tickerData.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Hot Coins",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 105,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tickerData.length < 4 ? tickerData.length : 4,
                  itemBuilder: (context, index) {
                    final item = tickerData[index];
                    final coinName =
                        item['s']?.substring(0, item['s']?.length ~/ 2) ?? '';
                    final price = item['p'] ?? '0.0';
                    final percentageChange = formatPercentage(item['P']);
                    final isNegative = (item['P'] ?? '').startsWith('-');

                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      width: 130,
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: AppColor().darkCharcoal, // Set your desired border color here
                            width: 1.0, // Set the border width if needed
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    coinName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  CircleAvatar(
                                    child: Text("${coinName[0]}"),
                                    backgroundColor: AppColor().brightBlue,
                                    radius: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '₹ $price',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    color: isNegative
                                        ? AppColor().darkMaroon
                                        : AppColor().darkGreen,
                                    child: Container(
                                      margin: const EdgeInsets.all(2),
                                      child: Text(
                                        percentageChange,
                                        style: TextStyle(
                                          color: isNegative
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const Center(
            child: Text(
              "No data available",
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  Widget _buildZones() {
    return tickerData.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text(
                  "Zones",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 300 / 160,
                  ),
                  itemCount: tickerData.length < 4 ? tickerData.length : 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = tickerData[index];
                    final coinName =
                        item['s']?.substring(0, item['s']?.length ~/ 2) ?? '';
                    final price = item['p'] ?? '0.0';
                    final percentageChange = formatPercentage(item['P']);
                    final isNegative = (item['P'] ?? '').startsWith('-');

                    return Container(
                      alignment: Alignment.center,
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: AppColor().darkCharcoal, // Set your desired border color here
                            width: 1.0, // Set the border width if needed
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['T'],
                                    style: TextStyle(
                                      color: Colors.white30,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    '18 Coins',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        child: Text(coinName.isNotEmpty
                                            ? "${coinName[0]}"
                                            : ""),
                                        backgroundColor: AppColor().brightBlue,
                                        radius: 12,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '₹ $coinName',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Card(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                    ),
                                    color: isNegative
                                        ? AppColor().darkMaroon
                                        : AppColor().darkGreen,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        percentageChange,
                                        style: TextStyle(
                                          color: isNegative
                                              ? Colors.red
                                              : Colors.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        : const Center(
            child: Text(
              "No data available",
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColor().brightBlue,
          size: 25,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String subtitle, IconData icon) {
    return Expanded(
      child: Card(
        color: AppColor().darkCharcoal,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: AppColor().brightBlue,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
