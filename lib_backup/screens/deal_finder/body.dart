import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:roobai/core/api/app_api.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/features/product/data/model/deal_model.dart';
import 'amazon_fin.dart'; // Assume this page exists

class DealFinder extends StatefulWidget {
  const DealFinder({Key? key}) : super(key: key);

  @override
  State<DealFinder> createState() => _DealFinderState();
}

class _DealFinderState extends State<DealFinder> {
  bool loading = true;
  bool hasError = false;
  DealModel? dealData;
  List<Providers> providers = [];

  // Color schemes per provider
  final List<Color> flipkartColors = [Color(0xFF64b3f4), Color(0xFFc2e59c)];
  final List<Color> myntraColors = [Color(0xFFFe83e8c), Colors.white54];
  final List<Color> amazonColors = [Color(0xFFFF9900), Colors.black26];

  @override
  void initState() {
    super.initState();
    fetchDeals();
  }

  Future<void> fetchDeals() async {
    try {
      final url = "https://roo.bi/api/flutter/v12.0/deal_finder//flipkart/";
      final response = await http.get(Uri.parse(url), headers: APIS.headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final model = DealModel.fromJson(data);

        if (model.status == "1") {
          setState(() {
            dealData = model;
            providers = model.providers ?? [];
            loading = false;
          });
        } else {
          setState(() {
            hasError = true;
            loading = false;
          });
        }
      } else {
        throw Exception("Failed to load deals");
      }
    } catch (e) {
      setState(() {
        hasError = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deal Finder"),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text("Failed to load deals"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (dealData?.title1 != null)
                        Text(dealData!.title1!,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      const SizedBox(height: 10),
                      if (dealData?.title2 != null)
                        Text(dealData!.title2!,
                            style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 30),
                      Expanded(
                        child: ListView.separated(
                          itemCount: providers.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final provider = providers[index];
                            final colors = provider.type == "flipkart"
                                ? flipkartColors
                                : provider.type == "myntra"
                                    ? myntraColors
                                    : amazonColors;

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => amazon_finder(
                                      provider,
                                      dealData!.dealCat!,
                                      colors,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: colors,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 8,
                                      offset: Offset(2, 4),
                                    )
                                  ],
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Image.network(
                                      provider.image ?? "",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(provider.title ?? '',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          Text(provider.text ?? '',
                                              style: const TextStyle(fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios_rounded,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
