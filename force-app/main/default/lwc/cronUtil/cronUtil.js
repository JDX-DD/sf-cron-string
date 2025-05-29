const SELECTION_TYPE = Object.freeze({
  ALL: 'ALL',
  SINGLE: 'SINGLE',
  RANGE: 'RANGE',
  LIST: 'LIST',
  INCREMENT: 'INCREMENT',
  LAST: 'LAST',
  NEAREST: 'NEAREST',
  NTH: 'NTH',
  NONE: 'NONE'
});

const buildUnitOptionPicklist = (selection_types, unit_type) => {
    for(let selection_type of selection_types){
        if (!Object.values(SELECTION_TYPE).includes(selection_type)) {
            throw new Error(`Invalid type. Expected: ${Object.values(SELECTION_TYPE).join(', ')}`);
        }
    }    

    let unitPicklistOptions = [];

    if(selection_types.includes(SELECTION_TYPE.ALL)){
        unitPicklistOptions.push({ label: `Every ${unit_type}`, value: SELECTION_TYPE.ALL});
    }
    if(selection_types.includes(SELECTION_TYPE.RANGE)){
        unitPicklistOptions.push({ label: `Range of ${unit_type}s`, value: SELECTION_TYPE.RANGE})
    }
    if(selection_types.includes(SELECTION_TYPE.LIST)){
        unitPicklistOptions.push({ label: `List of ${unit_type}s`, value: SELECTION_TYPE.LIST})
    }
    if(selection_types.includes(SELECTION_TYPE.INCREMENT)){
        unitPicklistOptions.push({ label: `${unit_type} Increment`, value: SELECTION_TYPE.INCREMENT})
    }
    if(selection_types.includes(SELECTION_TYPE.NEAREST)){
        unitPicklistOptions.push({ label: `Closest ${unit_type} to specified day`, value: SELECTION_TYPE.NEAREST})
    }
    if(selection_types.includes(SELECTION_TYPE.NTH)){
        unitPicklistOptions.push({ label: `Specific ${unit_type} of month`, value: SELECTION_TYPE.NTH})
    }    
    if(selection_types.includes(SELECTION_TYPE.LAST)){
        unitPicklistOptions.push({ label: `Last ${unit_type}`, value: SELECTION_TYPE.LAST})
    }
    if(selection_types.includes(SELECTION_TYPE.NONE)){
        unitPicklistOptions.push({ label: `None`, value: SELECTION_TYPE.NONE})
    }
    return unitPicklistOptions;
}

const buildRangePicklistOptions = (unit_range) => {  
  const rangePicklistOptions = [];
  for(let value of unit_range){
    rangePicklistOptions.push({ label: value.toString(), value: value.toString()});
  }
  return rangePicklistOptions;
}
    

const TYPE_TO_INPUTS = new Map([
  ['ALL', {picklist_1 : false, picklist_2 : false, integer_input: false, list_inputs: false}],
  ['SINGLE', {picklist_1 : true, picklist_2 : false, integer_input: false, list_inputs: false}],
  ['RANGE', {picklist_1 : true, picklist_2 : true, integer_input: false, list_inputs: false}],
  ['LIST', {picklist_1 : false, picklist_2 : false, integer_input: false, list_inputs: true}],
  ['INCREMENT', {picklist_1 : true, picklist_2 : false, integer_input: true, list_inputs: false}],
  ['LAST', {picklist_1 : false, picklist_2 : false, integer_input: false, list_inputs: false}],
  ['NEAREST', {picklist_1 : true, picklist_2 : false, integer_input: false, list_inputs: false}],
  ['NTH', {picklist_1 : true, picklist_2 : false, integer_input: true, list_inputs: false}],
  ['NONE', {picklist_1 : false, picklist_2 : false, integer_input: false, list_inputs: false}],

]);



const buildSelectionString =  (selection_type, pl1Value, pl2Value, numValue, listArray, lastOverride) => {
  if (!Object.values(SELECTION_TYPE).includes(selection_type)) {
    throw new Error(`Invalid type. Expected: ${Object.values(SELECTION_TYPE).join(', ')}`);
  }
  let chronStringSegment = '';
  if (selection_type === SELECTION_TYPE.SINGLE) {
    chronStringSegment = `${pl1Value}`;
  }
  if (selection_type === SELECTION_TYPE.RANGE) {
    chronStringSegment = `${pl1Value}-${pl2Value}`;
  }
  if (selection_type === SELECTION_TYPE.LIST) {
    chronStringSegment = listArray.join(',');
  }
  if (selection_type === SELECTION_TYPE.INCREMENT) {
    chronStringSegment = `${pl1Value}/${numValue}`;
  }
  if (selection_type === SELECTION_TYPE.LAST) {
    if(lastOverride){
      chronStringSegment = `${pl1Value}L`;
    }
    else{
      chronStringSegment = 'L';
    }    
  }
  if (selection_type === SELECTION_TYPE.NEAREST) {
    chronStringSegment = `${pl1Value}W`;
  }
  if (selection_type === SELECTION_TYPE.NTH) {
    chronStringSegment = `${pl1Value}#${numValue}`;
  }
  if (selection_type === SELECTION_TYPE.ALL) {
    chronStringSegment = '*';
  }
  if (selection_type === SELECTION_TYPE.NONE) {
    chronStringSegment = '?';
  }
  return chronStringSegment;
}

export {SELECTION_TYPE, buildUnitOptionPicklist, buildRangePicklistOptions, TYPE_TO_INPUTS,  buildSelectionString};