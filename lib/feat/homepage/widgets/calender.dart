import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  late Map<DateTime, bool> _expandedWeeks;

  @override
  void initState() {
    super.initState();
    _focusedDate = DateTime.now();
    _selectedDate = DateTime.now();
    _expandedWeeks = {}; // 날짜별 확장 상태 저장
  }

  // 월을 시작하는 날짜와 마지막 날짜 계산
  List<DateTime> _getDaysInMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = List.generate(
      endOfMonth.day,
      (index) => startOfMonth.add(Duration(days: index)),
    );
    return daysInMonth;
  }

  // 주를 계산하는 함수 (특정 날짜가 속한 주의 첫 번째 날짜를 계산)
  DateTime _getStartOfWeek(DateTime day) {
    // 월요일을 주의 시작으로 설정
    return day.subtract(Duration(days: (day.weekday - 1) % 7));
  }

  // 주간에 표시할 날짜 계산
  List<DateTime> _getWeekDates(DateTime day) {
    final startOfWeek = _getStartOfWeek(day);
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  // 요일 표시를 위한 리스트
  final List<String> _weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  // 이전, 다음 달의 날짜를 회색으로 처리하기 위한 함수
  bool _isSameMonth(DateTime day) {
    return day.month == _focusedDate.month && day.year == _focusedDate.year;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_focusedDate);

    // 첫 번째 날짜가 월요일부터 시작하도록 보정
    final firstDayOfMonth = daysInMonth.first;
    final firstDayOfWeek = _getStartOfWeek(firstDayOfMonth);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Calendar'),
      ),
      body: Column(
        children: [
          // 상단: 현재 월을 표시
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(
                        _focusedDate.year,
                        _focusedDate.month - 1,
                        1,
                      );
                    });
                  },
                ),
                Text(
                  DateFormat.yMMMM().format(_focusedDate),
                  style: const TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(
                        _focusedDate.year,
                        _focusedDate.month + 1,
                        1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          // 요일 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _weekdays.map((weekday) {
              return Expanded(
                child: Center(
                  child: Text(
                    weekday,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
          ),

          // 날짜 그리기
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 7일 기준으로 한 주를 나타냄
              ),
              itemCount: (firstDayOfWeek.day == DateTime.monday
                      ? 0
                      : (7 - firstDayOfWeek.weekday) % 7) +
                  daysInMonth.length,
              itemBuilder: (context, index) {
                final day = firstDayOfWeek.add(Duration(days: index));
                final isSelected = _selectedDate == day;
                final isExpanded =
                    _expandedWeeks[_getStartOfWeek(day)] ?? false;
                final isInCurrentMonth = _isSameMonth(day);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = day;
                      final startOfWeek = _getStartOfWeek(day);
                      _expandedWeeks[startOfWeek] =
                          !_expandedWeeks[startOfWeek]!;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: !isInCurrentMonth
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : isInCurrentMonth
                                    ? Colors.black
                                    : Colors.grey,
                          ),
                        ),
                      ),
                      if (isExpanded) // 확장되는 UI 표시
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Additional events for ${day.month}/${day.day}',
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
