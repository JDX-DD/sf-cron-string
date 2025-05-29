public with sharing class CronStringBuilderController {
  @AuraEnabled
  public static String buildCronString(
    String yearOption,
    String startYear,
    String endYear,
    String listYear,
    String incrementYear,
    String monthOption,
    String startMonth,
    String endMonth,
    String listMonth,
    String incrementMonth,
    String dayOptionType,
    String dayOfMonthOption,
    String startDayOfMonth,
    String endDayOfMonth,
    String listDayOfMonth,
    String incrementDayOfMonth,
    String dayOfWeekOption,
    String startDayOfWeek,
    String endDayOfWeek,
    String listDayOfWeek,
    String incrementDayOfWeek,
    String nth,
    String hourOption,
    String startHour,
    String endHour,
    String listHour,
    String incrementHour,
    String minute,
    String second
  ) {
    System.debug('Start Year = ' + startYear);
    List<SchedularStringBuilder.CronInfo> cronInfoMap = new List<SchedularStringBuilder.CronInfo>();
    SchedularStringBuilder.CronInfo yearCronInfo = new SchedularStringBuilder.CronInfo(
      SchedularStringBuilder.TimeTypeEnum.YEAR,
      getScheduleTypeEnum(yearOption, startYear, endYear),
      integerValue(startYear),
      integerValue(endYear),
      listYear,
      integerValue(incrementYear)
    );
    cronInfoMap.add(yearCronInfo);
    SchedularStringBuilder.CronInfo monthCronInfo = new SchedularStringBuilder.CronInfo(
      SchedularStringBuilder.TimeTypeEnum.MONTH,
      getScheduleTypeEnum(monthOption, startMonth, endMonth),
      integerValue(startMonth),
      integerValue(endMonth),
      listMonth,
      integerValue(incrementMonth)
    );
    cronInfoMap.add(monthCronInfo);
    if (dayOptionType == 'All') {
      SchedularStringBuilder.CronInfo dayOfMonthCronInfo = new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.ALL,
        null,
        null,
        null,
        null
      );
      cronInfoMap.add(dayOfMonthCronInfo);
    } else if (dayOptionType == 'Month') {
      SchedularStringBuilder.CronInfo dayOfMonthCronInfo = new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_MONTH,
        getScheduleTypeEnum(dayOfMonthOption, startDayOfMonth, endDayOfMonth),
        integerValue(startDayOfMonth),
        integerValue(endDayOfMonth),
        listDayOfMonth,
        integerValue(incrementDayOfMonth)
      );
      cronInfoMap.add(dayOfMonthCronInfo);
    } else if (dayOptionType == 'Week') {
      SchedularStringBuilder.CronInfo dayOfMonthCronInfo = new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_WEEK,
        getScheduleTypeEnum(dayOfWeekOption, startDayOfWeek, endDayOfWeek),
        integerValue(startDayOfWeek),
        integerValue(endDayOfWeek),
        listDayOfWeek,
        integerValue(incrementDayOfWeek),
        integerValue(nth)
      );
      cronInfoMap.add(dayOfMonthCronInfo);
    }
    SchedularStringBuilder.CronInfo hourCronInfo = new SchedularStringBuilder.CronInfo(
      SchedularStringBuilder.TimeTypeEnum.HOURS,
      getScheduleTypeEnum(hourOption, startHour, endHour),
      integerValue(startHour),
      integerValue(endHour),
      listHour,
      integerValue(incrementHour)
    );
    cronInfoMap.add(hourCronInfo);
    SchedularStringBuilder.CronInfo minuteCronInfo = new SchedularStringBuilder.CronInfo(
      SchedularStringBuilder.TimeTypeEnum.MINUTES,
      SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
      integerValue(minute),
      null,
      null,
      null
    );
    cronInfoMap.add(minuteCronInfo);
    SchedularStringBuilder.CronInfo secondCronInfo = new SchedularStringBuilder.CronInfo(
      SchedularStringBuilder.TimeTypeEnum.SECONDS,
      SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
      integerValue(second),
      null,
      null,
      null
    );
    cronInfoMap.add(secondCronInfo);

    String cronString = SchedularStringBuilder.buildCronString(cronInfoMap);
    System.debug('Cron String = ' + cronString);
    return cronString;
  }

  private static SchedularStringBuilder.ScheduleTypeEnum getScheduleTypeEnum(
    String option,
    String startValue,
    String endValue
  ) {
    SchedularStringBuilder.ScheduleTypeEnum scheduleType;
    if (option == 'All') {
      scheduleType = SchedularStringBuilder.ScheduleTypeEnum.ALL;
    } else if (option == 'Range') {
      if (startValue == endValue) {
        scheduleType = SchedularStringBuilder.ScheduleTypeEnum.SINGLE;
      } else {
        scheduleType = SchedularStringBuilder.ScheduleTypeEnum.RANGE;
      }
    } else if (option == 'List') {
      scheduleType = SchedularStringBuilder.ScheduleTypeEnum.LST;
    } else if (option == 'Increment') {
      scheduleType = SchedularStringBuilder.ScheduleTypeEnum.INCREMENT;
    } else if (option == 'Last') {
      scheduleType = SchedularStringBuilder.ScheduleTypeEnum.LAST;
    } else if (option == 'Nth') {
      scheduleType = SchedularStringBuilder.ScheduleTypeEnum.NTH;
    } else if (option == 'Nearist') {
      scheduleType = SchedularStringBuilder.ScheduleTypeEnum.NEARIST;
    } else {
      scheduleType = SchedularStringBuilder.ScheduleTypeEnum.NONE;
    }
    return scheduleType;
  }

  public static Integer integerValue(String stringInt) {
    if (stringInt != null && stringInt != '') {
      return Integer.valueOf(stringInt);
    } else {
      return null;
    }
  }

  @AuraEnabled
  public static String getTimeTypeEnum() {
    try {
      return String.valueOf(SchedularStringBuilder.TimeTypeEnum.SECONDS);
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
