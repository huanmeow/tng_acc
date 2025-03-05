import 'package:flutter/material.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  List<Map<String, dynamic>> _accounts = [

  ];

  int? _selectedAccountId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản Lý Tài Khoản Game'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _accounts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_accounts[index]['username']),
                  subtitle: Text(_accounts[index]['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _selectedAccountId = _accounts[index]['id'];
                          _usernameController.text = _accounts[index]['username'];
                          _emailController.text = _accounts[index]['email'];
                          _passwordController.text = _accounts[index]['password'];
                          showDialog(
                            context: context,
                            builder: (context) => _buildDialog(context, true),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _accounts.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _selectedAccountId = null;
              _usernameController.clear();
              _emailController.clear();
              _passwordController.clear();
              showDialog(
                context: context,
                builder: (context) => _buildDialog(context, false),
              );
            },
            child: Text('Thêm Tài Khoản'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialog(BuildContext context, bool isEditing) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isEditing ? 'Sửa Tài Khoản' : 'Thêm Tài Khoản'),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Tên Người Chơi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên người chơi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật Khẩu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isEditing) {
                      // Sửa tài khoản
                      final index = _accounts.indexWhere((account) => account['id'] == _selectedAccountId);
                      if (index != -1) {
                        setState(() {
                          _accounts[index]['username'] = _usernameController.text;
                          _accounts[index]['email'] = _emailController.text;
                          _accounts[index]['password'] = _passwordController.text;
                        });
                      }
                    } else {
                      // Thêm tài khoản
                      setState(() {
                        _accounts.add({
                          'id': _accounts.length + 1,
                          'username': _usernameController.text,
                          'email': _emailController.text,
                          'password': _passwordController.text,
                        });
                      });
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(isEditing ? 'Lưu Thay Đổi' : 'Thêm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}