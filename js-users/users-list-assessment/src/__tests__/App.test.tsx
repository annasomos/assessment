import UserPagination from "../components/UserPagination";
import { render, screen, cleanup } from "@testing-library/react";
import { BrowserRouter, useNavigate } from "react-router-dom";
import User from "../components/User";
import UserForm from "../components/UserForm";
import AddNewUser from "../components/AddNewUser";
import { api } from "../api/api";

beforeEach(() => {
  cleanup();
});

afterEach(() => {
  cleanup();
});

const mockResponsePagination = [
  {
    id: 723,
    last_name: "s",
    first_name: "shiiiish",
    status: "active",
    created_at: "2022-12-07T07:22:14.839Z",
    updated_at: "2023-01-02T17:32:29.893Z",
    url: "https://assessment-users-backend.herokuapp.com/users/723.json",
  },
  {
    id: 727,
    last_name: "prox1669",
    first_name: "ani update somos",
    status: "locked",
    created_at: "2022-12-07T19:54:08.096Z",
    updated_at: "2023-01-02T09:07:58.865Z",
    url: "https://assessment-users-backend.herokuapp.com/users/727.json",
  },
  {
    id: 838,
    last_name: "a",
    first_name: "a",
    status: "locked",
    created_at: "2022-12-12T01:01:56.417Z",
    updated_at: "2022-12-27T22:27:04.762Z",
    url: "https://assessment-users-backend.herokuapp.com/users/838.json",
  },
  {
    id: 820,
    last_name: "a",
    first_name: "a",
    status: "locked",
    created_at: "2022-12-12T00:26:59.746Z",
    updated_at: "2023-01-02T09:42:36.174Z",
    url: "https://assessment-users-backend.herokuapp.com/users/820.json",
  },
  {
    id: 607,
    last_name: "w",
    first_name: "w",
    status: "active",
    created_at: "2022-12-02T15:55:58.655Z",
    updated_at: "2022-12-29T17:36:06.737Z",
    url: "https://assessment-users-backend.herokuapp.com/users/607.json",
  },
  {
    id: 725,
    last_name: "a",
    first_name: "a",
    status: "active",
    created_at: "2022-12-07T08:17:07.918Z",
    updated_at: "2022-12-27T22:27:10.726Z",
    url: "https://assessment-users-backend.herokuapp.com/users/725.json",
  },
];

test("List all users, get 6 user cards on screen", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponsePagination} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/Created at/);
  expect(text.length).toBe(6);
});

test("List all users, get 1 user with name shiiiish", () => {
  render(
    <BrowserRouter>
      <UserPagination users={mockResponsePagination} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/shiiiish/);
  expect(text.length).toBe(1);
});

test("Render User component of User 727", () => {
  render(
    <BrowserRouter>
      <User user={mockResponsePagination[1]} />
    </BrowserRouter>
  );
  const text = screen.getAllByText(/prox1669/);
  expect(text.length).toBe(1);
});

test("Render UserForm component of User 727", () => {
  const handleOnSubmit = async (event: any) => {
    const navigateTo = useNavigate();
    event.preventDefault();
    const updatedUser = {
      first_name: event.target["first_name"].value,
      last_name: event.target["last_name"].value,
    };
    await api.updateUserById(`${mockResponsePagination[1].id}`, updatedUser);
    navigateTo("../");
  };

  render(
    <BrowserRouter>
      <UserForm
        user={mockResponsePagination[1]}
        handleOnSubmit={handleOnSubmit}
      />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/ani update somos/);
  const last_name = screen.getAllByDisplayValue(/prox1669/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
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