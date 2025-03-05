import 'package:flutter/material.dart';
import 'package:shopmeo/Admin/ChucNang/admin_main.dart';
import 'package:shopmeo/Admin/ChucNang/bank_main.dart';
import 'ChucNang/history_main.dart';
import 'ChucNang/profile_admin.dart';


class AdminApp extends StatefulWidget {
  const AdminApp({super.key});

  @override
  State<AdminApp> createState() => _AdminAppState();
}
class _AdminAppState extends State<AdminApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(['Trang Chủ', 'Lịch Sử', 'Quản Lí Nạp/CK', 'Tài Khoản']
        [currentPageIndex]),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.yellow[200],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Trang Chủ',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.history)),
            label: 'Lịch Sử Bán',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.attach_money)),
            label: 'QL Nạp Tiền',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.account_circle_rounded)),
            label: 'Tài Khoản',
          ),
        ],
      ),
      body: [
        // Trang Chủ
        AdminMain(),

        // Lịch Sử
        HistoryMain(),

        // Tin Nhắn
        BankMain(),

        // Tài Khoản
        ProfileAdmin(),
      ][currentPageIndex],
    );
  }

  }
