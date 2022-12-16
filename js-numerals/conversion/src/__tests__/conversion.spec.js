import {convertNumber, britishConversion} from '../conversion'

test('7 === seven', () => {
  expect(convertNumber(7)).toBe('seven');
})