import { useState, useEffect } from "react";
import { UserModel } from "../model/UserModel";
import UserPagination from "./UserPagination";
import { api } from "../api/api";
import { MDBSpinner } from "mdb-react-ui-kit";

const UserList = () => {
  const [allUsers, setAllUsers] = useState<UserModel[]>([]);

  const [isLoading, setIsLoading] = useState<boolean>(false);

  async function getUsers() {
    setIsLoading(true);
    const users = await api.getAllUsers();
    setAllUsers(users);
    setIsLoading(false);
  }

  useEffect(() => {
    getUsers();
  }, []);

  return (
    <>
      {isLoading ? (
        <MDBSpinner className="m-5" role="status">
          <span className="visually-hidden">Loading...</span>
        </MDBSpinner>
      ) : (
          <UserPagination users={allUsers} />
      )}
    </>
  );
};

export default UserList;
