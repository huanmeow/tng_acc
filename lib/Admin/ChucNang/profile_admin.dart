import 'package:flutter/material.dart';
import 'package:shopmeo/Account/login_screen.dart';

import '../image_admin.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({super.key});

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.blue,
          child: AccountPage(),
        ),
        SizedBox(height: 15),
        Center(
          child: Text(
            'Admin Mai Huan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
            // Xử lý khi nhấn nút này
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đã nhấn nút')),
            );
          },
          child: Text('Thay Đổi Mật Khẩu'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Xử lý khi nhấn nút này
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đã nhấn nút')),
            );
          },
          child: Text('Cài Đặt Thông Báo'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isLoading=true;
            });
            Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
            // Xử lý khi nhấn nút này
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đã đăng xuất')),
            );
          },
          child: Text('Đăng xuất'),
        ),
      ],
    );
  }
}
