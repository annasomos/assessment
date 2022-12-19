import App from "../App";
import {render, screen, fireEvent, cleanup} from '@testing-library/react';

beforeEach(()=> {
  cleanup();
})

afterEach(()=> {
  cleanup();
})

test('User types a whole number between 0 and 999999999', () => {
  render(<App/>);
  const input = screen.getByPlaceholderText("Enter a number");
  fireEvent.change(input, {target: {value: '7'}});
  const text = screen.getAllByText(/seven/);
  expect(text.length).toBe(2);
})