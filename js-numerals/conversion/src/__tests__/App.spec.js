import App from "../App";
import {render, screen, fireEvent, cleanup} from '@testing-library/react';

beforeEach(()=> {
  cleanup();
})

afterEach(()=> {
  cleanup();
})

test('User types 7', () => {
  render(<App/>);
  const input = screen.getByPlaceholderText("Enter a number");
  fireEvent.change(input, {target: {value: '7'}});
  const text = screen.getAllByText(/seven/);
  expect(text.length).toBe(2);
})

test('User types 42', () => {
  render(<App/>);
  const input = screen.getByPlaceholderText("Enter a number");
  fireEvent.change(input, {target: {value: '42'}});
  const text = screen.getAllByText(/forty-two/);
  expect(text.length).toBe(2);
})