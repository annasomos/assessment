import {convertNumber, britishConversion} from '../conversion'

test('7 === seven', () => {
  expect(convertNumber(7)).toBe('seven');
  expect(britishConversion(7)).toBe('seven');
})

test('42 === forty-two', () => {
  expect(convertNumber(42)).toBe('forty-two');
  expect(britishConversion(42)).toBe('forty-two');
})

