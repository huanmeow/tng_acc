import 'package:flutter/material.dart';
class BankMain extends StatefulWidget {
  const BankMain({super.key});

  @override
  State<BankMain> createState() => _BankMainState();
}

class _BankMainState extends State<BankMain> {
  List<CardRecharge> _cardRecharges = [
    CardRecharge(
        id: '1',
        telcoProvider: 'Viettel',
        amount: 100000,
        status: 'Thành Công',
        date: DateTime.now()
    ),
    CardRecharge(
        id: '2',
        telcoProvider: 'Mobifone',
        amount: 50000,
        status: 'Thành Công',
        date: DateTime.now().subtract(Duration(days: 1))
    ),
  ];

  List<MoneyTransfer> _moneyTransfers = [
    MoneyTransfer(
        id: '1',
        recipientName: 'Nguyễn Văn A',
        bankName: 'Vietcombank',
        amount: 500000,
        status: 'Thành Công',
        date: DateTime.now()
    ),
    MoneyTransfer(
        id: '2',
        recipientName: 'Trần Thị B',
        bankName: 'BIDV',
        amount: 300000,
        status: 'Thành Công',
        date: DateTime.now().subtract(Duration(days: 2))
    ),
  ];

  // Hàm hiển thị dialog nạp thẻ
  void _showRechargeDialog() {
    final _amountController = TextEditingController();
    final _telcoProviders = ['Viettel', 'Mobifone', 'Vinaphone'];
    String _selectedProvider = 'Viettel';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Nạp Thẻ Điện Thoại'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedProvider,
                    decoration: InputDecoration(
                      labelText: 'Nhà Mạng',
                      border: OutlineInputBorder(),
                    ),
                    items: _telcoProviders.map((provider) {
                      return DropdownMenuItem(
                        value: provider,
                        child: Text(provider),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProvider = value!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Số Tiền Nạp',
                      border: OutlineInputBorder(),
                      suffixText: 'VND',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Hủy'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final amount = int.tryParse(_amountController.text);
                    if (amount != null) {
                      setState(() {
                        _cardRecharges.add(CardRecharge(
                          id: (_cardRecharges.length + 1).toString(),
                          telcoProvider: _selectedProvider,
                          amount: amount,
                          status: 'Thành Công',
                          date: DateTime.now(),
                        ));
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Nạp Thẻ'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Hàm hiển thị dialog chuyển khoản
  void _showTransferDialog() {
    final _recipientController = TextEditingController();
    final _bankController = TextEditingController();
    final _amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chuyển Khoản'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _recipientController,
                decoration: InputDecoration(
                  labelText: 'Tên Người Nhận',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _bankController,
                decoration: InputDecoration(
                  labelText: 'Ngân Hàng',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Số Tiền Chuyển',
                  border: OutlineInputBorder(),
                  suffixText: 'VND',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = int.tryParse(_amountController.text);
                if (amount != null) {
                  setState(() {
                    _moneyTransfers.add(MoneyTransfer(
                      id: (_moneyTransfers.length + 1).toString(),
                      recipientName: _recipientController.text,
                      bankName: _bankController.text,
                      amount: amount,
                      status: 'Thành Công',
                      date: DateTime.now(),
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Chuyển Khoản'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quản Lý Ngân Hàng'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Nạp Thẻ'),
              Tab(text: 'Chuyển Khoản'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Trang Nạp Thẻ
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: _showRechargeDialog,
                    icon: Icon(Icons.add_circle),
                    label: Text('Nạp Thẻ Mới'),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _cardRecharges.length,
                    itemBuilder: (context, index) {
                      final recharge = _cardRecharges[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          child: Icon(Icons.phone_android, color: Colors.green),
                        ),
                        title: Text(recharge.telcoProvider),
                        subtitle: Text('${recharge.amount.toString()} VND'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              recharge.status,
                              style: TextStyle(
                                color: recharge.status == 'Thành Công'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Text(
                              '${recharge.date.day}/${recharge.date.month}/${recharge.date.year}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Trang Chuyển Khoản
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: _showTransferDialog,
                    icon: Icon(Icons.add_circle),
                    label: Text('Chuyển Khoản Mới'),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _moneyTransfers.length,
                    itemBuilder: (context, index) {
                      final transfer = _moneyTransfers[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(Icons.account_balance, color: Colors.blue),
                        ),
                        title: Text(transfer.recipientName),
                        subtitle: Text(transfer.bankName),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${transfer.amount.toString()} VND',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              transfer.status,
                              style: TextStyle(
                                color: transfer.status == 'Thành Công'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Text(
                              '${transfer.date.day}/${transfer.date.month}/${transfer.date.year}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Lớp lưu thông tin nạp thẻ
class CardRecharge {
  final String id;
  final String telcoProvider;
  final int amount;
  final String status;
  final DateTime date;

  CardRecharge({
    required this.id,
    required this.telcoProvider,
    required this.amount,
    required this.status,
    required this.date,
  });
}

// Lớp lưu thông tin chuyển khoản
class MoneyTransfer {
  final String id;
  final String recipientName;
  final String bankName;
  final int amount;
  final String status;
  final DateTime date;

  MoneyTransfer({
    required this.id,
    required this.recipientName,
    required this.bankName,
    required this.amount,
    required this.status,
    required this.date,
  });
}