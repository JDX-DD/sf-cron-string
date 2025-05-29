import { SELECTION_TYPE, buildUnitOptionPicklist, buildRangePicklistOptions, buildSelectionString } from 'c/cronUtil';

describe('c-cron-util', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('Test buildUnitOptionPicklist function with valid and invalid selection types', () => {
        // Test with valid selection types
        const validSelectionTypes = [SELECTION_TYPE.ALL, SELECTION_TYPE.RANGE, SELECTION_TYPE.LIST, SELECTION_TYPE.INCREMENT, SELECTION_TYPE.NEAREST, SELECTION_TYPE.NTH, SELECTION_TYPE.LAST, SELECTION_TYPE.NONE];
        const unitType = 'testUnit';
        const validOptions = buildUnitOptionPicklist(validSelectionTypes, unitType);
        expect(validOptions).toHaveLength(8);

        // Test with invalid selection type
        const invalidSelectionTypes = ['INVALID_TYPE'];
        expect(() => {
            buildUnitOptionPicklist(invalidSelectionTypes, unitType);
        }).toThrow('Invalid type. Expected: ALL, SINGLE, RANGE, LIST, INCREMENT, LAST, NEAREST, NTH, NONE');
    });

    it('Test buildRangePicklistOptions function with a sample range', () => {
        const unitRange = [1, 2, 3, 4, 5];
        const rangeOptions = buildRangePicklistOptions(unitRange);
        expect(rangeOptions).toHaveLength(5);
        expect(rangeOptions[0].label).toBe('1');
        expect(rangeOptions[0].value).toBe('1');
    });

    it('Test buildSelectionString function with various selection types and values', () => {
        // Test with SINGLE selection type
        let selectionString = buildSelectionString(SELECTION_TYPE.SINGLE, '1', null, null, null, false);
        expect(selectionString).toBe('1');

        // Test with RANGE selection type
        selectionString = buildSelectionString(SELECTION_TYPE.RANGE, '1', '5', null, null, false);
        expect(selectionString).toBe('1-5');

        // Test with LIST selection type
        selectionString = buildSelectionString(SELECTION_TYPE.LIST, null, null, null, ['1', '2', '3'], false);
        expect(selectionString).toBe('1,2,3');

        // Test with INCREMENT selection type
        selectionString = buildSelectionString(SELECTION_TYPE.INCREMENT, '1', null, 2, null, false);
        expect(selectionString).toBe('1/2');

        // Test with LAST selection type
        selectionString = buildSelectionString(SELECTION_TYPE.LAST, null, null, null, null, false);
        expect(selectionString).toBe('L');

        // Test with NEAREST selection type
        selectionString = buildSelectionString(SELECTION_TYPE.NEAREST, '1', null, null, null, false);
        expect(selectionString).toBe('1W');

        // Test with NTH selection type
        selectionString = buildSelectionString(SELECTION_TYPE.NTH, '1', null, 2, null, false);
        expect(selectionString).toBe('1#2');

        // Test with ALL selection type
        selectionString = buildSelectionString(SELECTION_TYPE.ALL, null, null, null, null, false);
        expect(selectionString).toBe('*');

        // Test with NONE selection type
        selectionString = buildSelectionString(SELECTION_TYPE.NONE, null, null, null, null, false);
        expect(selectionString).toBe('?');
    });
});