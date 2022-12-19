import {convertNumber, britishConversion} from '../conversion'

test('7 === seven', () => {
  expect(convertNumber(7)).toBe('seven');
  expect(britishConversion(7)).toBe('seven');
})

test('42 === forty-two', () => {
  expect(convertNumber(42)).toBe('forty-two');
  expect(britishConversion(42)).toBe('forty-two');
})

test('1999 === one thousand nine hundred and ninety-nine', () => {
  expect(convertNumber(1999)).toBe('one thousand nine hundred and ninety-nine');
})

test('1999 === nineteen hundred and ninety-nine', () => {
  expect(britishConversion(1999)).toBe('nineteen hundred and ninety-nine');
})

test('2001 === two thousand and one', () => {
  expect(convertNumber(2001)).toBe('two thousand and one');
})

