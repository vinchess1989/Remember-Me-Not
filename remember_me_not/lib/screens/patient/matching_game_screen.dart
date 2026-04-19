import 'package:flutter/material.dart';
import 'dart:async';
import '../../theme/app_theme.dart';
import '../../widgets/memory_card.dart';
import '../../services/photo_service.dart';

class GameCardData {
  final String id;
  final IconData? icon;
  final String? imageUrl;
  final String matchId;

  GameCardData({
    required this.id,
    this.icon,
    this.imageUrl,
    required this.matchId,
  });
}

class MatchingGameScreen extends StatefulWidget {
  const MatchingGameScreen({super.key});

  @override
  State<MatchingGameScreen> createState() => _MatchingGameScreenState();
}

class _MatchingGameScreenState extends State<MatchingGameScreen> {
  final List<IconData> _fallbackIcons = [
    Icons.pets,
    Icons.directions_car,
    Icons.local_florist,
    Icons.music_note,
    Icons.cake,
    Icons.airplanemode_active,
  ];

  List<GameCardData> _cards = [];
  List<bool> _isFlipped = [];
  List<bool> _isMatched = [];

  int _previousIndex = -1;
  bool _isProcessing = false;
  int _matches = 0;
  int _moves = 0;
  int _totalPairs = 6;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    final uploadedPhotos = PhotoService.instance.photos;
    final List<GameCardData> baseCards = [];

    // Use uploaded photos if we have at least 6
    if (uploadedPhotos.length >= 6) {
      _totalPairs = 6;
      for (int i = 0; i < 6; i++) {
        baseCards.add(GameCardData(
          id: 'photo_$i',
          imageUrl: uploadedPhotos[i].imageUrl,
          matchId: uploadedPhotos[i].id,
        ));
      }
    } else {
      // Fallback to icons
      _totalPairs = _fallbackIcons.length;
      for (int i = 0; i < _fallbackIcons.length; i++) {
        baseCards.add(GameCardData(
          id: 'icon_$i',
          icon: _fallbackIcons[i],
          matchId: _fallbackIcons[i].codePoint.toString(),
        ));
      }
    }

    _cards = [...baseCards, ...baseCards];
    _cards.shuffle();

    _isFlipped = List<bool>.filled(_cards.length, false);
    _isMatched = List<bool>.filled(_cards.length, false);
    _previousIndex = -1;
    _isProcessing = false;
    _matches = 0;
    _moves = 0;
    setState(() {});
  }

  void _onCardTap(int index) {
    if (_isProcessing || _isFlipped[index] || _isMatched[index]) return;

    setState(() {
      _isFlipped[index] = true;
    });

    if (_previousIndex == -1) {
      _previousIndex = index;
    } else {
      _moves++;
      _isProcessing = true;
      _checkForMatch(index);
    }
  }

  void _checkForMatch(int currentIndex) {
    if (_cards[_previousIndex].matchId == _cards[currentIndex].matchId) {
      // Match found
      setState(() {
        _isMatched[_previousIndex] = true;
        _isMatched[currentIndex] = true;
        _previousIndex = -1;
        _isProcessing = false;
        _matches++;
      });

      if (_matches == _totalPairs) {
        _showWinDialog();
      }
    } else {
      // No match
      Timer(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isFlipped[_previousIndex] = false;
            _isFlipped[currentIndex] = false;
            _previousIndex = -1;
            _isProcessing = false;
          });
        }
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Congratulations!',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: AppTheme.accentYellow, size: 64),
              const SizedBox(height: 16),
              Text(
                'You found all pairs in $_moves moves!',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to home screen
              },
              child: const Text('Back to Home', style: TextStyle(fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _initializeGame();
              },
              child: const Text('Play Again', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Game'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Moves: $_moves',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  Text(
                    'Pairs: $_matches / $_totalPairs',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    final card = _cards[index];
                    return MemoryCard(
                      icon: card.icon,
                      imageUrl: card.imageUrl,
                      isFlipped: _isFlipped[index],
                      isMatched: _isMatched[index],
                      onTap: () => _onCardTap(index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
