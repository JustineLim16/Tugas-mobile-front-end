import 'package:flutter/material.dart';

class MoneyNotifier extends ChangeNotifier {
  List<Map<String, dynamic>> all = [
    {
      "category": "income",
      "description": "Transfer",
      "date": DateTime(2024, 4, 2),
      "price": 200000
    },
    {
      "category": "income",
      "description": "Saving",
      "date": DateTime(2024, 4, 2),
      "price": 2000000
    },
    {
      "category": "expense",
      "description": "Clothes",
      "date": DateTime(2024, 4, 2),
      "price": 1000000
    },
    {
      "category": "expense",
      "description": "Food",
      "date": DateTime(2024, 4, 2),
      "price": 200000
    },
    {
      "category": "expense",
      "description": "Transfer",
      "date": DateTime(2024, 4, 2),
      "price": 1000000
    },
    {
      "category": "income",
      "description": "Transfer",
      "date": DateTime(2024, 4, 2),
      "price": 500000
    },
    {
      "category": "expense",
      "description": "Food",
      "date": DateTime(2024, 4, 1),
      "price": 150000
    },
    {
      "category": "expense",
      "description": "Subscription",
      "date": DateTime(2024, 4, 1),
      "price": 500000
    },
    {
      "category": "expense",
      "description": "Subscription",
      "date": DateTime(2024, 4, 1),
      "price": 1000000
    },
    {
      "category": "income",
      "description": "Salary",
      "date": DateTime(2024, 4, 1),
      "price": 4500000
    },
  ];

  List<Map<String, dynamic>> income = [
    {
      "description": "Transfer",
      "date": DateTime(2024, 4, 2),
      "price": 200000
    },
    {
      "description": "Saving",
      "date": DateTime(2024, 4, 2),
      "price": 2000000
    },
    {
      "description": "Transfer",
      "date": DateTime(2024, 4, 2),
      "price": 500000
    },
    {
      "description": "Salary",
      "date": DateTime(2024, 4, 1),
      "price": 4500000
    }
  ];

  List<Map<String, dynamic>> expense = [
    {
      "description": "Clothes",
      "date": DateTime(2024, 4, 2),
      "price": 1000000
    },
    {
      "description": "Food",
      "date": DateTime(2024, 4, 2),
      "price": 200000
    },
    {
      "description": "Transfer",
      "date": DateTime(2024, 4, 2),
      "price": 1000000
    },
    {
      "description": "Food",
      "date": DateTime(2024, 4, 1),
      "price": 150000
    },
    {
      "description": "Subscription",
      "date": DateTime(2024, 4, 1),
      "price": 500000
    },
    {
      "description": "Subscription",
      "date": DateTime(2024, 4, 1),
      "price": 1000000
    },
  ];

  // Method to sort the list by date
  void _sortByDate(List<Map<String, dynamic>> list) {
    list.sort((a, b) => b['date'].compareTo(a['date']));
  }

  void updateMoney(Map<String, dynamic> data) {
    int selectedIndexAll = all.indexWhere((item) => item == data);

    if (selectedIndexAll == -1) {
      all.insert(0, data);
    }

    Map<String, dynamic> newData = {
      "description": data["description"],
      "date": data["date"],
      "price": data["price"]
    };

    if (data["category"] == "income") {
      int selectedIndexIn = income.indexWhere((item) => item == newData);

      if (selectedIndexIn == -1) {
        income.insert(0, newData);
      }
    } else if (data["category"] == "expense") {
      int selectedIndexOut = expense.indexWhere((item) => item == newData);

      if (selectedIndexOut == -1) {
        expense.insert(0, newData);
      }
    }

    _sortByDate(all);
    _sortByDate(income);
    _sortByDate(expense);

    notifyListeners();
  }

  void deleteMoney(Map<String, dynamic> data) {
    int selectedIndexAll = all.indexWhere((item) => item == data);

    if (selectedIndexAll >= 0) {
      all.removeAt(selectedIndexAll);
    }

    Map<String, dynamic> newData = {
      "description": data["description"],
      "date": data["date"],
      "price": data["price"]
    };

    if (data["category"] == "income") {
      int selectedIndexIn = income.indexWhere((item) => item == newData);

      if (selectedIndexIn >= 0) {
        income.removeAt(selectedIndexIn);
      }
    } else if (data["category"] == "expense") {
      int selectedIndexOut = expense.indexWhere((item) => item == newData);

      if (selectedIndexOut >= 0) {
        expense.removeAt(selectedIndexOut);
      }
    }

    _sortByDate(all);
    _sortByDate(income);
    _sortByDate(expense);

    notifyListeners();
  }
}
