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

test('User submits 42', () => {
  render(<App/>)
  const input = screen.getByPlaceholderText("Enter a number");
  const button = screen.getByText('Convert');
  fireEvent.change(input, {target: {value: '42'}});
  fireEvent.click(button);
  const text = screen.getAllByText(/forty-two/);
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
