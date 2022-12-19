import App from "../App";
import {render, screen, cleanup, userEvent, fireEvent} from '@testing-library/react';

beforeEach(()=> {
  cleanup();
})

afterEach(()=> {
  cleanup();
})

test('User submits 7', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '7'}});
  fireEvent.click(button);
  const text = screen.getAllByText(/seven/);
  expect(text.length).toBe(1);
})

test('User submits -7', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-7'}});
  fireEvent.click(button);
  const text = screen.getAllByText(/negative seven/);
  expect(text.length).toBe(1);
})

test('User submits 42', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '42'}});
  fireEvent.click(button);
  const text = screen.getAllByText(/forty-two/);
  expect(text.length).toBe(1);
})

test('User submits -42', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-42'}});
  fireEvent.click(button);
  const text = screen.getAllByText(/negative forty-two/);
  expect(text.length).toBe(1);
})

test('User submits 1999', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '1999'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/one thousand nine hundred and ninety-nine/);
  expect(textUS.length).toBe(1);
  const textUK = screen.getAllByText(/nineteen hundred and ninety-nine/);
  expect(textUK.length).toBe(1);
})

test('User submits -1999', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-1999'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/negative one thousand nine hundred and ninety-nine/);
  expect(textUS.length).toBe(1);
  const textUK = screen.getAllByText(/negative nineteen hundred and ninety-nine/);
  expect(textUK.length).toBe(1);
})

test('User submits 2001', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '2001'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/two thousand and one/);
  expect(textUS.length).toBe(1);
})

test('User submits -2001', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-2001'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/negative two thousand and one/);
  expect(textUS.length).toBe(1);
})

test('User submits 17999', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '17999'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/seventeen thousand nine hundred and ninety-nine/);
  expect(textUS.length).toBe(1);
})

test('User submits -17999', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-17999'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/negative seventeen thousand nine hundred and ninety-nine/);
  expect(textUS.length).toBe(1);
})

test('User submits 100001', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '100001'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/one hundred thousand and one/);
  expect(textUS.length).toBe(1);
})

test('User submits -100001', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-100001'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/negative one hundred thousand and one/);
  expect(textUS.length).toBe(1);
})

test('User submits 342251', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '342251'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/three hundred and forty-two thousand two hundred and fifty-one/);
  expect(textUS.length).toBe(1);
})

test('User submits -342251', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-342251'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/negative three hundred and forty-two thousand two hundred and fifty-one/);
  expect(textUS.length).toBe(1);
})


test('User submits 1300420', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '1300420'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/one million three hundred thousand four hundred and twenty/);
  expect(textUS.length).toBe(1);
})

test('User submits -1300420', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-1300420'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/negative one million three hundred thousand four hundred and twenty/);
  expect(textUS.length).toBe(1);
})

test('User submits 0', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '0'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/zero/);
  expect(textUS.length).toBe(1);
})

test('User submits empty string', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: ''}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/Invalid input/);
  expect(textUS.length).toBe(1);
})

test('User submits 999999999', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '999999999'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/nine hundred and ninety-nine million nine hundred and ninety-nine thousand nine hundred and ninety-nine/);
  expect(textUS.length).toBe(1);
})

test('User submits -999999999', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '-999999999'}});
  fireEvent.click(button);
  const textUS = screen.getAllByText(/negative nine hundred and ninety-nine million nine hundred and ninety-nine thousand nine hundred and ninety-nine/);
  expect(textUS.length).toBe(1);
})

