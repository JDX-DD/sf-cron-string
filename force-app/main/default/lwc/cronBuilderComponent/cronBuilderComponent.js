import { LightningElement } from "lwc";
import { SELECTION_TYPE, buildRangePicklistOptions } from "c/cronUtil";

export default class CronBuilderComponent extends LightningElement {
  cronStringSegments = ["0", "0", "?", "?", "?", "?", "?"];
  cronString = "0 0 ? ? ? ? ?";

  yearUnitType = "Year";
  yearUnitRage = [];
  yearSelectionTypes = [
    SELECTION_TYPE.ALL,
    SELECTION_TYPE.RANGE,
    SELECTION_TYPE.LIST,
    SELECTION_TYPE.INCREMENT
  ];

  monthUnitType = "Month";
  monthUnitRange = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  monthSelectionTypes = [
    SELECTION_TYPE.ALL,
    SELECTION_TYPE.RANGE,
    SELECTION_TYPE.LIST,
    SELECTION_TYPE.INCREMENT
  ];

  weekDayUnitType = "Week Day";
  weekDayUnitRange = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  weekDaySelectionTypes = [
    SELECTION_TYPE.ALL,
    SELECTION_TYPE.RANGE,
    SELECTION_TYPE.LIST,
    SELECTION_TYPE.INCREMENT,
    SELECTION_TYPE.LAST,
    SELECTION_TYPE.NTH
  ];
  showWeekDay = false;

  dayUnitType = "Day";
  dayUnitRange = [];
  daySelectionTypes = [
    SELECTION_TYPE.ALL,
    SELECTION_TYPE.RANGE,
    SELECTION_TYPE.LIST,
    SELECTION_TYPE.INCREMENT,
    SELECTION_TYPE.LAST,
    SELECTION_TYPE.NEAREST
  ];
  showMonthDay = false;

  hourUnitType = "Hour";
  hourUnitRange = [];
  hourSelectionTypes = [
    SELECTION_TYPE.ALL,
    SELECTION_TYPE.RANGE,
    SELECTION_TYPE.LIST,
    SELECTION_TYPE.INCREMENT
  ];

  minuteOptions = [];
  secondOptions = [];

  get dayPicklistOptions() {
    const options = [];
    options.push({ label: "Day(s) of Month", value: "MonthDay" });
    options.push({ label: "Day(s) of Week", value: "WeekDay" });
    return options;
  }

  handleDayPicklistOptionChange(event) {
    if (event.detail.value === "MonthDay") {
      this.cronStringSegments[5] = "?";
      this.showWeekDay = false;
      this.showMonthDay = true;
      this.buildCronString();
    } else if (event.detail.value === "WeekDay") {
      this.cronStringSegments[3] = "?";
      this.showWeekDay = true;
      this.showMonthDay = false;
      this.buildCronString();
    }
  }

  connectedCallback() {
    this.yearUnitRage = Array.from({ length: 130 }, (_, i) => 1970 + i);
    this.dayUnitRange = Array.from({ length: 31 }, (_, i) => 1 + i);
    this.hourUnitRange = Array.from({ length: 24 }, (_, i) => 0 + i);

    const minuteUnitRange = Array.from({ length: 60 }, (_, i) => 0 + i);
    this.minuteOptions = buildRangePicklistOptions(minuteUnitRange);
    this.secondOptions = [...this.minuteOptions];
  }

  handleYearChange(event) {
    console.log(event.detail);
    this.cronStringSegments[6] = event.detail;
    this.buildCronString();
  }

  handleMonthChange(event) {
    console.log(event.detail);
    this.cronStringSegments[4] = event.detail;
    this.buildCronString();
  }

  handleWeekDayChange(event) {
    console.log(event.detail);
    this.cronStringSegments[5] = event.detail;
    this.buildCronString();
  }

  handleDayChange(event) {
    console.log(event.detail);
    this.cronStringSegments[3] = event.detail;
    this.buildCronString();
  }

  handleHourChange(event) {
    console.log(event.detail);
    this.cronStringSegments[2] = event.detail;
    this.buildCronString();
  }

  handleMinuteChange(event) {
    console.log(event.detail);
    this.cronStringSegments[1] = event.detail.value;
    this.buildCronString();
  }

  handleSecondChange(event) {
    console.log(event.detail);
    this.cronStringSegments[0] = event.detail.value;
    this.buildCronString();
  }

  buildCronString() {
    this.cronString = this.cronStringSegments.join(" ");
  }
}
