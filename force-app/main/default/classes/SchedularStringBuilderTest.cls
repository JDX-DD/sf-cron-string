@isTest
private class SchedularStringBuilderTest {
  @IsTest
  static void testSingleValueCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        30,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        15,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        12,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        6,
        null,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '30 15 12 ? 6 ? ',
      cronString,
      'Single value cron string should match expected format'
    );
  }

  @IsTest
  static void testRangeCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.RANGE,
        10,
        20,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.RANGE,
        5,
        15,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.RANGE,
        8,
        12,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.RANGE,
        1,
        6,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '10-20 5-15 8-12 ? 1-6 ? ',
      cronString,
      'Range cron string should match expected format'
    );
  }

  @IsTest
  static void testListCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.LST,
        null,
        null,
        '15,30,45',
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.LST,
        null,
        null,
        '0,15,30',
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.LST,
        null,
        null,
        '9,12,15',
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.LST,
        null,
        null,
        '1,6,12',
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '15,30,45 0,15,30 9,12,15 ? 1,6,12 ? ',
      cronString,
      'List cron string should match expected format'
    );
  }

  @IsTest
  static void testIncrementCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.INCREMENT,
        0,
        null,
        null,
        15
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.INCREMENT,
        0,
        null,
        null,
        10
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.INCREMENT,
        0,
        null,
        null,
        2
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.INCREMENT,
        1,
        null,
        null,
        3
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '0/15 0/10 0/2 ? 1/3 ? ',
      cronString,
      'Increment cron string should match expected format'
    );
  }

  @IsTest
  static void testAllCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.ALL,
        null,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.ALL,
        null,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.ALL,
        null,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.ALL,
        null,
        null,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '* * * ? * ? ',
      cronString,
      'All cron string should match expected format'
    );
  }

  @IsTest
  static void testLastCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.LAST,
        null,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        1,
        null,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '0 0 0 L 1 ? ',
      cronString,
      'Last cron string should match expected format'
    );
  }

  @IsTest
  static void testNearestWeekdayCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.NEARIST,
        15,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        1,
        null,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '0 0 0 15W 1 ? ',
      cronString,
      'Nearest weekday cron string should match expected format'
    );
  }

  @IsTest
  static void testNthCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        1,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_WEEK,
        SchedularStringBuilder.ScheduleTypeEnum.NTH,
        2,
        null,
        null,
        null,
        3
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '0 0 0 ? 1 2#3 ',
      cronString,
      'Nth cron string should match expected format'
    );
  }

  @IsTest
  static void testNoneCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        1,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_WEEK,
        SchedularStringBuilder.ScheduleTypeEnum.NONE,
        null,
        null,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '0 0 0 ? 1 ? ',
      cronString,
      'None cron string should match expected format'
    );
  }

  @IsTest
  static void testYearCronString() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.SECONDS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MINUTES,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.HOURS,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        0,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        1,
        null,
        null,
        null
      )
    );
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.YEAR,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        2025,
        null,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '0 0 0 ? 1 ?  2025',
      cronString,
      'Year cron string should match expected format'
    );
  }

  @IsTest
  static void testExceptionHandling() {
    List<SchedularStringBuilder.CronInfo> cronInfos = new List<SchedularStringBuilder.CronInfo>();
    // Missing required SECONDS, MINUTES, HOURS, MONTH
    cronInfos.add(
      new SchedularStringBuilder.CronInfo(
        SchedularStringBuilder.TimeTypeEnum.DAY_OF_MONTH,
        SchedularStringBuilder.ScheduleTypeEnum.SINGLE,
        1,
        null,
        null,
        null
      )
    );

    String cronString = SchedularStringBuilder.buildCronString(cronInfos);
    System.assertEquals(
      '',
      cronString,
      'Empty string should be returned on exception'
    );
  }
}
