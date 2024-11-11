import 'package:flutter/material.dart';
import 'package:mobile_development/main.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FinanceApp extends StatelessWidget {
  const FinanceApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Finance(),
      ),
    );
  }
}

class Finance extends StatefulWidget {
  const Finance({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => FinanceState();
}

class FinanceState extends State<Finance> {
  String? selectedCategory;
  DateTime? selectedDate;
  String? description;
  double? valueMoney;
  String? type;
  DateTime? endDate;
  DateTime? newDate;
  String? addition;
  bool flag = true;

  void insertFinance() async {
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    await Supabase.instance.client.from('finance').insert({'category_name': selectedCategory, 'description': description, 'value': valueMoney, 'created_at': newDate.toString(), 'type': type});
  }

  popFinance(int index) async {
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    await Supabase.instance.client.from('finance').delete().eq('id', index);
  }

  Future<List<Map<String, dynamic>>> fetchFinance() async {
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    var query = Supabase.instance.client.from('finance').select();
    if (type != null) {
      query = query.eq('type', type!);
    }
    if (selectedDate != null) {
      query = query.gte('created_at', selectedDate!.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('created_at', endDate!.toIso8601String());
    }
    var response = await query;
    return response;
  }


  void insertNewCategory() async {
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    await Supabase.instance.client.from('finance_category').insert({'name' : selectedCategory});
  }

  Future<List<Map<String, dynamic>>> fetchCategory() async {
    await Supabase.instance.client.auth.signInWithPassword(email: 'hidwidwi@mail.ru', password: 'azUGyX278');
    var response =  await Supabase.instance.client.from('finance_category').select();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuApp()),
                );
              },
              child: const Text(
                'Меню',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                flag = !flag;
                fetchFinance();
              });
            },
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.filter_alt_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              getFilters();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addFinance,
        child: Icon(Icons.add_circle_sharp),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchFinance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } 
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет данных'));
          }
          final finance = snapshot.data!;
          final Map<String, double> categorySums = {};
          if (flag == true) {
            for (var category in finance) {
              final categoryName = category['category_name'].toString();
              final value = double.parse(category['value'].toString());
              if (categorySums.containsKey(categoryName)) {
                categorySums[categoryName] = categorySums[categoryName]! + value;
              } 
              else {
                categorySums[categoryName] = value;
              }
            }
          }
          else {
            for (var type in finance) {
              final typeType = type['type'].toString();
              final value = double.parse(type['value'].toString());
              if (categorySums.containsKey(typeType)) {
                categorySums[typeType] = categorySums[typeType]! + value;
              } 
              else {
                categorySums[typeType] = value;
              }
            }
          }
          return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: PieChart(
                  chartRadius: 250,
                  chartType: ChartType.ring,
                  animationDuration: Duration(milliseconds: 800),
                  dataMap: categorySums,
                  legendOptions: LegendOptions(legendPosition: LegendPosition.bottom, showLegendsInRow: true),
                ),
              ),
              Divider(color: Colors.blue.shade100, thickness: 2),
              Expanded(
                child: ListView.builder(
                  itemCount: finance.length,
                  itemBuilder: (context, index) {
                    final finances = finance[index];
                    if (finances['type'] == 'Расходы') {
                      addition = "-";
                    } 
                    else {
                      addition = "+";
                    }
                    return Column (
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            deleteFinance(finances['id']);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      finances['description'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      finances['category_name'],
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "$addition${finances['value']} руб",
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      finances['created_at'],
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void deleteFinance(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Удалить трату?"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  popFinance(index);
                  setState(() {
                    fetchFinance();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Удалить',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Отменить',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getFilters() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Фильтры"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                hint: Text("Выберите тип транзакции"),
                value: type,
                items: [
                  DropdownMenuItem(value: 'Доходы', child: Text("Доходы")),
                  DropdownMenuItem(value: 'Расходы', child: Text("Расходы")),
                ],
                onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                },
              ),
              ListTile(
                title: Text("Начальная дата"),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedStartDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (pickedStartDate != null) {
                      setState(() {
                        selectedDate = pickedStartDate;
                      });
                    }
                  },
                ),
              ),
              ListTile(
                title: Text("Конечная дата"),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedEndDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (pickedEndDate != null) {
                      setState(() {
                        endDate = pickedEndDate;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Применить"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  fetchFinance();
                });
              },
            ),
            TextButton(
              child: Text("Сбросить"),
              onPressed: () {
                setState(() {
                  selectedCategory = null;
                  type = null;
                  selectedDate = null;
                  endDate = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void addFinance() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Добавить трату"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } 
                  else if (snapshot.hasError) {
                    return Center(child: Text('Ошибка: ${snapshot.error}'));
                  } 
                  else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Нет данных'));
                  }
                  final categories = snapshot.data!;
                  return DropdownButton<String>(
                    hint: const Text("Выберите категорию"),
                    value: selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category['name'] ?? '',
                        child: Text(
                          category['name'] ?? ','
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val;
                      });
                    },
                  );
                },
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Или введите новую категорию'),
                ),
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val;
                  });
                },
              ),
              TextButton(
                child: Text("Применить"),
                onPressed: () async {
                  insertNewCategory();
                },
              ),
              ListTile(
                title: Text("Выберите дату"),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: newDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        newDate = pickedDate;
                      });
                    }
                  },
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text(
                    'Введите сумму',
                  )
                ),
                onChanged: (val) {
                  setState(() {
                    valueMoney = double.tryParse(val);
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text(
                    'Введите описание траты',
                  )
                ),
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
              ),
              DropdownButton<String>(
                hint: Text('Выберите тип транзакции'),
                value: type,
                items: ['Доходы', 'Расходы'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    type = val;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Применить"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  insertFinance();
                  fetchFinance();
                });
              },
            ),
            TextButton(
              child: Text("Сбросить"),
              onPressed: () {
                setState(() {
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
