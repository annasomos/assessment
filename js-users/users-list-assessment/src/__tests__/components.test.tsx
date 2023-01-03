import UserPagination from "../components/UserPagination";
import { render, screen, cleanup } from "@testing-library/react";
import { BrowserRouter } from "react-router-dom";
import User from "../components/User";
import UserForm from "../components/UserForm";
import AddNewUser from "../components/AddNewUser";
import { mockResponse } from "../util/testData";

beforeEach(() => {
  cleanup();
});

afterEach(() => {
  cleanup();
});

const handleUpdateOnSubmit = jest.fn();

test("List all users, get 6 user cards on screen", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Created at/);
  expect(text.length).toBe(6);
});

test("List all users, get 1 user with name Luna", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Luna/);
  expect(text.length).toBe(1);
});

test("List all users, get 1 user with name Harry", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Harry/);
  expect(text.length).toBe(1);
});

test("List all users, get 1 user with name Hermione", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Hermione/);
  expect(text.length).toBe(1);
});

test("List all users, get 1 user with name Ronald", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Ronald/);
  expect(text.length).toBe(1);
});

test("List all users, get 1 user with name Neville", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Neville/);
  expect(text.length).toBe(1);
});

test("List all users, get 1 user with name Sirius", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Sirius/);
  expect(text.length).toBe(1);
});

test("List all users, get all user cards with correct names", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponse} />
    </BrowserRouter>
  );
  const harry = screen.getAllByText(/Harry/);
  expect(harry.length).toBe(1);
  const luna = screen.getAllByText(/Luna/);
  expect(luna.length).toBe(1);
  const hermione = screen.getAllByText(/Hermione/);
  expect(hermione.length).toBe(1);
  const ronald = screen.getAllByText(/Ronald/);
  expect(ronald.length).toBe(1);
  const neville = screen.getAllByText(/Neville/);
  expect(neville.length).toBe(1);
  const sirius = screen.getAllByText(/Sirius/);
  expect(sirius.length).toBe(1);
});

test("Render User component of User 727", () => {
  render(
    <BrowserRouter>
      <User user={mockResponse[1]} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Harry/);
  expect(text.length).toBe(1);
});

test("Render User component of User 723", () => {
  render(
    <BrowserRouter>
      <User user={mockResponse[0]} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Lovegood/);
  expect(text.length).toBe(1);
});

test("Render User component of User 838", () => {
  render(
    <BrowserRouter>
      <User user={mockResponse[2]} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Ronald/);
  expect(text.length).toBe(1);
});

test("Render User component of User 820", () => {
  render(
    <BrowserRouter>
      <User user={mockResponse[3]} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Hermione/);
  expect(text.length).toBe(1);
});

test("Render User component of User 607", () => {
  render(
    <BrowserRouter>
      <User user={mockResponse[4]} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Neville/);
  expect(text.length).toBe(1);
});

test("Render User component of User 725", () => {
  render(
    <BrowserRouter>
      <User user={mockResponse[5]} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Black/);
  expect(text.length).toBe(1);
});

test("Render AddNewUser component", () => {
  render(
    <BrowserRouter>
      <AddNewUser />
    </BrowserRouter>
  );
  const lastNamePlaceholder = screen.getAllByPlaceholderText(/Last Name/);
  expect(lastNamePlaceholder.length).toBe(1);
  const firstNamePlaceholder = screen.getAllByPlaceholderText(/First Name/);
  expect(firstNamePlaceholder.length).toBe(1);
});

test("Render UserForm component of User 725", () => {
  render(
    <BrowserRouter>
      <UserForm user={mockResponse[5]} handleOnSubmit={handleUpdateOnSubmit} />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/Sirius/);
  const last_name = screen.getAllByDisplayValue(/Black/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
});

test("Render UserForm component of User 723", () => {
  render(
    <BrowserRouter>
      <UserForm user={mockResponse[0]} handleOnSubmit={handleUpdateOnSubmit} />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/Luna/);
  const last_name = screen.getAllByDisplayValue(/Lovegood/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
});

test("Render UserForm component of User 727", () => {
  render(
    <BrowserRouter>
      <UserForm user={mockResponse[1]} handleOnSubmit={handleUpdateOnSubmit} />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/Harry/);
  const last_name = screen.getAllByDisplayValue(/Potter/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
});

test("Render UserForm component of User 838", () => {
  render(
    <BrowserRouter>
      <UserForm user={mockResponse[2]} handleOnSubmit={handleUpdateOnSubmit} />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/Ronald/);
  const last_name = screen.getAllByDisplayValue(/Weasley/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
});

test("Render UserForm component of User 820", () => {
  render(
    <BrowserRouter>
      <UserForm user={mockResponse[3]} handleOnSubmit={handleUpdateOnSubmit} />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/Hermione/);
  const last_name = screen.getAllByDisplayValue(/Granger/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
});

test("Render UserForm component of User 607", () => {
  render(
    <BrowserRouter>
      <UserForm user={mockResponse[4]} handleOnSubmit={handleUpdateOnSubmit} />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/Neville/);
  const last_name = screen.getAllByDisplayValue(/Longbottom/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
});
