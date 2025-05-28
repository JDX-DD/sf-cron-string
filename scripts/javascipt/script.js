// script.js
import { buildSelectionString, buildUnitOptionPicklist } from '../../cron-string-builder/main/default/lwc/cronUtil/cronUtil.js';
import { SELECTION_TYPE, TYPE_TO_INPUTS } from '../../cron-string-builder/main/default/lwc/cronUtil/selection_type.js';
//console.log(buildSelectionString(SELECTION_TYPE.RANGE, 1999));
const rangeInputs = TYPE_TO_INPUTS.get(SELECTION_TYPE.RANGE);
console.log(rangeInputs);
const rangeOutputs = rangeInputs.processInputs('1999', '2015');
console.log(rangeOutputs);
