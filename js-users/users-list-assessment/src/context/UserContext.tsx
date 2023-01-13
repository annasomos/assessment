import { useState, useEffect, createContext, ReactElement } from "react";
import { UserModel } from "../model/UserModel";
import { api } from "../api/api";
import { MDBSpinner } from "mdb-react-ui-kit";

type UserContextType = {
  allUsers: UserModel[];
  setAllUsers: (users: UserModel[]) => void;
};

export const UserContext = createContext<UserContextType>({
  allUsers: [],
  setAllUsers: () => {},
});

type UserProviderProps = {
  children: ReactElement[];
};

const UserProvider = ({ children }: UserProviderProps) => {
  const [allUsers, setAllUsers] = useState<UserModel[] | null>(null);

  async function getUsers() {
    const users = await api.getAllUsers();
    setAllUsers(users);
  }

  useEffect(() => {
    getUsers();
  }, []);

  if (allUsers === null) {
    return (
      <MDBSpinner className="m-5" role="status">
        <span className="visually-hidden">Loading...</span>
      </MDBSpinner>
    );
  }

  return (
    <UserContext.Provider
      value={{ allUsers: allUsers, setAllUsers: setAllUsers }}
    >
      {children}
    </UserContext.Provider>
  );
};

export default UserProvider;
