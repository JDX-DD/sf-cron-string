//https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_scheduler.htm
//, - Delimiter
// - - Range
// ? - No specified value
// / - Increment
//L - last in range
//W = nearest Weekday
//# - day#day_of_month

// 'seconds minutes hours day_of_month month day_of_week optional_year'

//EXAMPLE:
/***********************************
SchedularStringBuilder.CronSecondsMeta seconds = new SchedularStringBuilder.CronSecondsMeta(0);
SchedularStringBuilder.CronMinutesMeta minutes = new SchedularStringBuilder.CronMinutesMeta(0);
SchedularStringBuilder.CronHoursMeta hours = new SchedularStringBuilder.CronHoursMeta(SchedularStringBuilder.ScheduleTypeEnum.SINGLE, 5, null, null);
SchedularStringBuilder.CronDaysOfMonthMeta daysOfMonth = new SchedularStringBuilder.CronDaysOfMonthMeta(SchedularStringBuilder.ScheduleTypeEnum.RANGE, 5, 10, null, null, null);
SchedularStringBuilder.CronMonthsMeta months = new SchedularStringBuilder.CronMonthsMeta(SchedularStringBuilder.ALL, null, null, null);
SchedularStringBuilder.CronDaysOfWeekMeta daysOfWeek = new SchedularStringBuilder.CronDaysOfWeekMeta(SchedularStringBuilder.ScheduleTypeEnum.NONE, null, null, null, null, null, null);
List<SchedularStringBuilder.CronInfo> cronMeta = new List<SchedularStringBuilder.CronInfo>();
cronMeta.add(seconds);
cronMeta.add(minutes);
cronMeta.add(hours);
cronMeta.add(daysOfMonth);
cronMeta.add(months);
cronMeta.add(daysOfWeek);
String cronString = SchedularStringBuilder.buildCronString(cronMeta);
System.debug('Cron String = ' + cronString);

***********************************/

global without sharing class SchedularStringBuilder {
  global enum TimeTypeEnum {
    SECONDS,
    MINUTES,
    HOURS,
    DAY_OF_MONTH,
    MONTH,
    DAY_OF_WEEK,
    YEAR
  }

  global enum ScheduleTypeEnum {
    SINGLE,
    ALL,
    RANGE,
    LST,
    INCREMENT,
    LAST,
    NEARIST,
    NTH,
    NONE
  }

  global static String buildCronString(List<CronInfo> cronInfos) {
    Map<TimeTypeEnum, CronInfo> cronInfoMap = new Map<TimeTypeEnum, CronInfo>();
    for (CronInfo info : cronInfos) {
      cronInfoMap.put(info.timeType, info);
    }
    String cronString = '';
    try {
      cronString +=
        cronInfoMap.get(TimeTypeEnum.SECONDS).buildCronSegment() + ' ';
      cronString +=
        cronInfoMap.get(TimeTypeEnum.MINUTES).buildCronSegment() + ' ';
      cronString +=
        cronInfoMap.get(TimeTypeEnum.HOURS).buildCronSegment() + ' ';
      if (cronInfoMap.get(TimeTypeEnum.DAY_OF_MONTH) != null) {
        cronString +=
          cronInfoMap.get(TimeTypeEnum.DAY_OF_MONTH).buildCronSegment() + ' ';
      } else {
        cronString += '? ';
      }
      cronString +=
        cronInfoMap.get(TimeTypeEnum.MONTH).buildCronSegment() + ' ';
      if (cronInfoMap.get(TimeTypeEnum.DAY_OF_WEEK) != null) {
        cronString +=
          cronInfoMap.get(TimeTypeEnum.DAY_OF_WEEK).buildCronSegment() + ' ';
      } else {
        cronString += '? ';
      }
      if (cronInfoMap.get(TimeTypeEnum.YEAR) != null) {
        cronString +=
          ' ' + cronInfoMap.get(TimeTypeEnum.YEAR).buildCronSegment();
      }
    } catch (Exception e) {
      System.debug('SchedularUtil Hit an error');
      System.debug(e.getMessage());
      System.debug(e.getStackTraceString());
    }
    return cronString;
  }

  global virtual class CronInfo {
    global TimeTypeEnum timeType;
    global ScheduleTypeEnum scheduleType;
    global String listValue;
    global Integer startValue;
    global Integer endValue;
    global Integer increment;
    global Integer nth;

    //Construtor for Hours, Months, Years, Day of Month
    global CronInfo(
      TimeTypeEnum timeType,
      ScheduleTypeEnum scheduleType,
      Integer startValue,
      Integer endValue,
      String listValue,
      Integer increment
    ) {
      this.timeType = timeType;
      this.scheduleType = scheduleType;
      this.startValue = startValue;
      this.endValue = endValue;
      this.listValue = listValue;
      this.increment = increment;
    }

    global CronInfo(
      TimeTypeEnum timeType,
      ScheduleTypeEnum scheduleType,
      Integer startValue,
      Integer endValue,
      String listValue,
      Integer increment,
      Integer nth
    ) {
      this.timeType = timeType;
      this.scheduleType = scheduleType;
      this.startValue = startValue;
      this.endValue = endValue;
      this.listValue = listValue;
      this.increment = increment;
      this.nth = nth;
    }

    String buildCronSegment() {
      switch on scheduleType {
        when SINGLE {
          return String.valueOf(startValue);
        }
        when RANGE {
          return String.valueOf(startValue) + '-' + String.valueOf(endValue);
        }
        when LST {
          return listValue;
        }
        when INCREMENT {
          return String.valueOf(startValue) + '/' + String.valueOf(increment);
        }
        when ALL {
          return String.valueOf('*');
        }
        when LAST {
          return 'L';
        }
        when NEARIST {
          return String.valueOf(startValue) + 'W';
        }
        when Nth {
          return String.valueOf(startValue) + '#' + String.valueOf(nth);
        }
        when NONE {
          return '?';
        }
        when else {
          //Throw custom exception
        }
      }
      return null;
    }
  }
}
