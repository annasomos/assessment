import {useState, useEffect} from "react";
import {UserModel} from "../model/UserModel";
import UserPagination from "./UserPagination";
import {api} from "../api/api";

const UserList = () => {

  const [allUsers, setAllUsers] = useState<UserModel[]>([]);

  async function getUsers() {
    const users = await api.getAllUsers();
    setAllUsers(users);
  }

  useEffect(() => {
    getUsers();
  }, []);

  return (
    <div>
        <UserPagination users={allUsers} />
    </div>
  );
};

export default UserList;