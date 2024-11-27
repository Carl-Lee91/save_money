import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:save_money/theme/app_colors.dart';

class CalenderWidget extends ConsumerStatefulWidget {
  const CalenderWidget({
    super.key,
    required this.focusedDate,
  });

  final DateTime focusedDate;

  @override
  ConsumerState<CalenderWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalenderWidget> {
  DateTime? _selectedDate;
  int? _expandedWeekIndex; // 확장할 주의 인덱스를 저장
  final Map<DateTime, List<String>> _dummyEvents = {}; // 더미 일정 데이터

  @override
  void initState() {
    super.initState();
    _initializeDummyEvents();
  }

  void _initializeDummyEvents() {
    // 달의 모든 날짜에 대한 더미 일정 추가
    for (int i = 0; i < 31; i++) {
      final date =
          DateTime(widget.focusedDate.year, widget.focusedDate.month, i + 1);
      _dummyEvents[date] = ['Event for ${date.day}/${date.month}'];
    }
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      endOfMonth.day,
      (index) => startOfMonth.add(Duration(days: index)),
    );
  }

  DateTime _getStartOfWeek(DateTime day) {
    return day.subtract(Duration(days: day.weekday % 7));
  }

  final List<String> _weekdays = [
    '일',
    '월',
    '화',
    '수',
    '목',
    '금',
    '토',
  ];

  bool _isSameMonth(DateTime day) {
    return day.month == widget.focusedDate.month &&
        day.year == widget.focusedDate.year;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(widget.focusedDate);
    final firstDayOfMonth = daysInMonth.first;
    final firstDayOfWeek = _getStartOfWeek(firstDayOfMonth);

    List<List<DateTime>> weeks = [];
    List<DateTime> currentWeek = [];
    for (DateTime day = firstDayOfWeek;
        day.isBefore(daysInMonth.last) || day == daysInMonth.last;
        day = day.add(const Duration(days: 1))) {
      currentWeek.add(day);
      if (currentWeek.length == 7) {
        weeks.add(currentWeek);
        currentWeek = [];
      }
    }
    if (currentWeek.isNotEmpty) {
      weeks.add(currentWeek);
    }

    if (weeks.isNotEmpty && weeks.last.length < 7) {
      DateTime lastDayOfMonth = daysInMonth.last;
      int daysToAdd = 7 - weeks.last.length;
      DateTime nextMonthDate =
          DateTime(lastDayOfMonth.year, lastDayOfMonth.month + 1, 1);

      for (int i = 0; i < daysToAdd; i++) {
        weeks.last.add(nextMonthDate.add(Duration(days: i)));
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _weekdays.map((weekday) {
            return Expanded(
              child: Center(
                child: Text(
                  weekday,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.disableTextColor,
                      ),
                ),
              ),
            );
          }).toList(),
        ),
        const Gap(12),
        SizedBox(
          height: 400,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: weeks.length,
            itemBuilder: (context, weekIndex) {
              final week = weeks[weekIndex];
              final isExpandedWeek = _expandedWeekIndex == weekIndex;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: week.map((day) {
                      final isSelected = _selectedDate == day;
                      final isInCurrentMonth = _isSameMonth(day);

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // 선택된 날짜가 이미 선택된 날짜와 동일하면 컨테이너를 숨김
                              if (_selectedDate == day) {
                                _selectedDate = null;
                                _expandedWeekIndex = null;
                              } else {
                                _selectedDate = day;
                                _expandedWeekIndex = weekIndex;
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isSelected ? Colors.blue : Colors.transparent,
                            ),
                            child: Text(
                              '${day.day}',
                              style: isSelected
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.whiteColor,
                                      )
                                  : isInCurrentMonth
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.mainTextColor,
                                          )
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.disableTextColor,
                                          ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Gap(2),
                  if (isExpandedWeek)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: AppColors.lineSubTextColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Events for ${_selectedDate?.day}/${_selectedDate?.month}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...(_dummyEvents[_selectedDate] ?? ['No events'])
                                .map(Text.new),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
