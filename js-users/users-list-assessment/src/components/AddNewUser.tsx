import { useNavigate } from "react-router-dom";
import { UserModel } from "../model/UserModel";
import { useContext } from "react";
import { api } from "../api/api";
import UserForm from "./UserForm";
import { UserContext } from "../context/UserContext";
import { MDBCard, MDBCardBody, MDBCardTitle } from "mdb-react-ui-kit";

const AddNewUser = () => {
  const navigateTo = useNavigate();
  const { allUsers, setAllUsers } = useContext(UserContext);

  type newUser = {
    first_name: string;
    last_name: string;
    status: string;
  };

  const handleAddUserOnSubmit = async (event: any) => {
    event.preventDefault();
    const newUserDetails: newUser = {
      first_name: event.target["first_name"].value,
      last_name: event.target["last_name"].value,
      status: "active",
    };
    const newUser: UserModel = await api.addNewUser(newUserDetails);
    setAllUsers([...allUsers, newUser]);
    navigateTo("../");
  };

  return (
    <MDBCard>
      <MDBCardBody>
        <MDBCardTitle>Add User</MDBCardTitle>
        <UserForm handleOnSubmit={handleAddUserOnSubmit} />
      </MDBCardBody>
    </MDBCard>
  );
};

export default AddNewUser;
