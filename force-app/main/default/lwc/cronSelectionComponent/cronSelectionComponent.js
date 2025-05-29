import { LightningElement, api } from "lwc";
import {
  SELECTION_TYPE,
  buildUnitOptionPicklist,
  buildRangePicklistOptions,
  TYPE_TO_INPUTS,
  buildSelectionString
} from "c/cronUtil";

export default class CronSelectionComponent extends LightningElement {
  @api selectionTypes;
  @api unitType;
  @api unitRange;
  @api lastOverride = false;

  selectionType;
  unitRangePicklistOptions = [];
  showPL1 = false;
  showPL2 = false;
  showNumInput = false;
  showListInputs = false;

  pl1Options = [];
  pl2Options = [];
  pl1Value;
  pl2Value;
  numValue;

  listPLValue;
  listArray = [];
  btnLabel = "Add To List";
  addLabel = "Add To List";
  removeLabel = "Remove From List";

  cronStringSegment;

  get selectionTypePicklistOptions() {
    return buildUnitOptionPicklist(this.selectionTypes, this.unitType);
  }

  get sectionTypeLabel() {
    return `Select ${this.unitType} Option`;
  }
  get plListOptions() {
    return buildRangePicklistOptions(this.unitRange);
  }

  connectedCallback() {
    this.pl1Options = buildRangePicklistOptions(this.unitRange);
    this.pl2Options = buildRangePicklistOptions(this.unitRange);
  }

  handleSelectionTypeChange(event) {
    this.selectionType = event.detail.value;
    let requiredInputs = TYPE_TO_INPUTS.get(this.selectionType);
    if (this.lastOverride && this.selectionType === SELECTION_TYPE.LAST) {
      this.showPL1 = true;
    } else {
      this.showPL1 = requiredInputs.picklist_1;
    }
    this.showPL2 = requiredInputs.picklist_2;
    this.showNumInput = requiredInputs.integer_input;
    this.showListInputs = requiredInputs.list_inputs;
    this.buildCronStringSegment();
  }

  handlePL1Change(event) {
    this.pl1Value = event.detail.value;
    const startIndex = this.pl1Options.findIndex(
      (item) => item.value === this.pl1Value
    );
    this.pl2Options = this.pl1Options.slice(startIndex);
    this.buildCronStringSegment();
  }

  handlePL2Change(event) {
    this.pl2Value = event.detail.value;
    this.buildCronStringSegment();
  }

  handleNumInputChange(event) {
    this.numValue = event.detail.value;
    this.buildCronStringSegment();
  }

  handlePLListChange(event) {
    this.listPLValue = event.detail.value;
    if (!this.listArray.includes(this.listPLValue)) {
      this.btnLabel = this.addLabel;
    } else {
      this.btnLabel = this.removeLabel;
    }
  }

  handleButtonChange() {
    if (!this.listArray.includes(this.listPLValue)) {
      this.listArray.push(this.listPLValue);
      this.listArray.sort((a, b) => a - b);
      this.buildCronStringSegment();
      this.btnLabel = this.removeLabel;
    } else {
      this.listArray = this.listArray.filter(
        (number) => number !== this.listPLValue
      );
      this.buildCronStringSegment();
      this.btnLabel = this.addLabel;
    }
  }

  buildCronStringSegment() {
    this.cronStringSegment = buildSelectionString(
      this.selectionType,
      this.pl1Value,
      this.pl2Value,
      this.numValue,
      this.listArray,
      this.lastOverride
    );
    const selectEvent = new CustomEvent("cronchange", {
      detail: this.cronStringSegment
    });
    this.dispatchEvent(selectEvent);
  }
}
