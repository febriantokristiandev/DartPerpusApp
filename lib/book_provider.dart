import 'package:flutter/material.dart';

class BookProvider with ChangeNotifier {
  List<String> _wishlist = [];
  List<String> _borrowedBooks = [];
  List<String> _queue = [];

  List<Map<String, dynamic>> _actionHistory = [];

  List<String> get wishlist => _wishlist;
  List<String> get borrowedBooks => _borrowedBooks;
  List<String> get queue => _queue;

  List<Map<String, dynamic>> get actionHistory => _actionHistory;

  void addToWishlist(String bookId) {
    _wishlist.add(bookId);
    notifyListeners();
  }

  void borrowBook(String bookId) {
    _borrowedBooks.add(bookId);
    _addToHistory('borrow_book', bookId);
    notifyListeners();
  }

  void addToQueue(String bookId) {
    _queue.add(bookId);
    notifyListeners();
  }

  void removeFromQueue(String bookId) {
    _queue.remove(bookId);
    notifyListeners();
  }

  void removeFromWishlist(String bookId) {
    _wishlist.remove(bookId);
    notifyListeners();
  }

  void returnBook(String bookId) {
    _borrowedBooks.remove(bookId);
    _addToHistory('return_book', bookId);
    notifyListeners();
  }

  void _addToHistory(String actionType, String bookId) {
    _actionHistory.add({
      'timestamp': DateTime.now(),
      'action': actionType,
      'bookId': bookId,
    });
    notifyListeners();
  }
}
