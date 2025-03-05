import 'package:flutter/material.dart';
import '../../Tienich/contants.dart';
import '../../models/account.dart';
import '../../services/databaseSe.dart';
class MySearchBAR extends StatefulWidget {
  const MySearchBAR({super.key});

  @override
  State<MySearchBAR> createState() => _MySearchBARState();
}

class _MySearchBARState extends State<MySearchBAR> {
  final _searchController = TextEditingController();
  List<Account> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kcontentColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm',
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                _searchAccounts(value);
              },
            ),
          ),
          // Hiển thị kết quả tìm kiếm trong ListView.builder, không cần Expanded
          // if (_searchResults.isNotEmpty) // Chỉ hiển thị khi có kết quả
          //   Expanded( // Sử dụng Expanded để ListView chiếm không gian còn lại
          //     child: ListView.builder(
          //       shrinkWrap: true, // Quan trọng: để ListView nằm trong Container
          //       itemCount: _searchResults.length,
          //       itemBuilder: (context, index) {
          //         return AccountCard(account: _searchResults[index]);
          //       },
          //     ),
          //   ),
        ],
      ),
    );
  }

  void _searchAccounts(String keyword) {
    DatabaseService().searchAccounts(keyword).then((results) {
      setState(() {
        _searchResults = results;
      });
    });
  }
}