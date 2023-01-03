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

const mockResponse = [
  {
    id: 723,
    last_name: "Luna",
    first_name: "Lovegood",
    status: "active",
    created_at: "2022-12-07T07:22:14.839Z",
    updated_at: "2023-01-02T17:32:29.893Z",
    url: "https://assessment-users-backend.herokuapp.com/users/723.json",
  },
  {
    id: 727,
    last_name: "Harry",
    first_name: "Potter",
    status: "locked",
    created_at: "2022-12-07T19:54:08.096Z",
    updated_at: "2023-01-02T09:07:58.865Z",
    url: "https://assessment-users-backend.herokuapp.com/users/727.json",
  },
  {
    id: 838,
    last_name: "Ronald",
    first_name: "Weasley",
    status: "locked",
    created_at: "2022-12-12T01:01:56.417Z",
    updated_at: "2022-12-27T22:27:04.762Z",
    url: "https://assessment-users-backend.herokuapp.com/users/838.json",
  },
  {
    id: 820,
    last_name: "Hermione",
    first_name: "Granger",
    status: "locked",
    created_at: "2022-12-12T00:26:59.746Z",
    updated_at: "2023-01-02T09:42:36.174Z",
    url: "https://assessment-users-backend.herokuapp.com/users/820.json",
  },
  {
    id: 607,
    last_name: "Neville",
    first_name: "Longbottom",
    status: "active",
    created_at: "2022-12-02T15:55:58.655Z",
    updated_at: "2022-12-29T17:36:06.737Z",
    url: "https://assessment-users-backend.herokuapp.com/users/607.json",
  },
  {
    id: 725,
    last_name: "Sirius",
    first_name: "Black",
    status: "active",
    created_at: "2022-12-07T08:17:07.918Z",
    updated_at: "2022-12-27T22:27:10.726Z",
    url: "https://assessment-users-backend.herokuapp.com/users/725.json",
  },
];

const handleUpdateOnSubmit = async (event: any, userId: string) => {
  const navigateTo = useNavigate();
  event.preventDefault();
  const updatedUser = {
    first_name: event.target["first_name"].value,
    last_name: event.target["last_name"].value,
  };
  await api.updateUserById(userId, updatedUser);
  navigateTo("../");
};

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
      <UserForm
        user={mockResponse[5]}
        handleOnSubmit={(e: any) =>
          handleUpdateOnSubmit(e, `${mockResponse[5].id}`)
        }
      />
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
      <UserForm
        user={mockResponse[0]}
        handleOnSubmit={(e: any) =>
          handleUpdateOnSubmit(e, `${mockResponse[0].id}`)
        }
      />
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
      <UserForm
        user={mockResponse[1]}
        handleOnSubmit={(e: any) =>
          handleUpdateOnSubmit(e, `${mockResponse[1].id}`)
        }
      />
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
      <UserForm
        user={mockResponse[2]}
        handleOnSubmit={(e: any) =>
          handleUpdateOnSubmit(e, `${mockResponse[2].id}`)
        }
      />
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
      <UserForm
        user={mockResponse[3]}
        handleOnSubmit={(e: any) =>
          handleUpdateOnSubmit(e, `${mockResponse[3].id}`)
        }
      />
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
      <UserForm
        user={mockResponse[4]}
        handleOnSubmit={(e: any) =>
          handleUpdateOnSubmit(e, `${mockResponse[4].id}`)
        }
      />
    </BrowserRouter>
  );
  const first_name = screen.getAllByDisplayValue(/Neville/);
  const last_name = screen.getAllByDisplayValue(/Longbottom/);
  expect(first_name.length).toBe(1);
  expect(last_name.length).toBe(1);
});
