// --- CustomAppBar.dart ---
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final ValueChanged<String>? onSearchChanged;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onSearchChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _controller = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _controller.addListener(() {
      setState(() {
        _showClearIcon = _controller.text.isNotEmpty;
      });
    });
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == "done" || status == "notListening") {
          setState(() => _isListening = false);
        }
      },
      onError: (error) {
        debugPrint("Speech recognition error: \$error");
        setState(() => _isListening = false);
      },
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          _controller.text = result.recognizedWords;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
          widget.onSearchChanged?.call(result.recognizedWords);
        },
      );
    } else {
      debugPrint("Speech recognition not available");
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        child: AppBar(
          elevation: 4,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00695C), Color(0xFF004D40)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'القرآن',
                    style: GoogleFonts.amiri(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade600,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.white, size: 20),
                        const SizedBox(width: 4),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            onChanged: widget.onSearchChanged,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'Search Surah...',
                              hintStyle: TextStyle(color: Colors.white70, fontSize: 13),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                        if (_showClearIcon)
                          GestureDetector(
                            onTap: () {
                              _controller.clear();
                              widget.onSearchChanged?.call('');
                            },
                            child: const Icon(Icons.clear, size: 18, color: Colors.white),
                          ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            _isListening ? _stopListening() : _startListening();
                          },
                          child: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          centerTitle: false,
        ),
      ),
    );
  }
}