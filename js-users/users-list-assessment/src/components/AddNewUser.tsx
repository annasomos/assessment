import { useNavigate } from "react-router-dom";
import { api } from "../api/api";
import UserForm from "./UserForm";
import { MDBCard, MDBCardBody, MDBCardTitle } from "mdb-react-ui-kit";

const AddNewUser = () => {
  const navigateTo = useNavigate();

  type newUser = {
    first_name: string;
    last_name: string;
    status: string;
  };

  const handleOnSubmit = async (event: any) => {
    event.preventDefault();
    const newUser: newUser = {
      first_name: event.target["first_name"].value,
      last_name: event.target["last_name"].value,
      status: "active",
    };
    await api.addNewUser(newUser);
    navigateTo("../");
  };
  return (
    <MDBCard>
      <MDBCardBody>
        <MDBCardTitle>Add User</MDBCardTitle>
        <UserForm handleOnSubmit={handleOnSubmit} />
      </MDBCardBody>
    </MDBCard>
  );
};

export default AddNewUser;
