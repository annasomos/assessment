import { useContext } from "react";
import UserPagination from "./UserPagination";
import { MDBSpinner } from "mdb-react-ui-kit";
import { UserContext } from "../context/UserContext";

const UserList = () => {

  return <UserPagination />;
};

export default UserList;
