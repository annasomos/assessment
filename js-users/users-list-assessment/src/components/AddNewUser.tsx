import { useNavigate } from "react-router-dom";
import { api } from "../api/api";
import UserForm from "./UserForm";

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
    <>
      <div className="heading">
        <h1 className="heading__title">Add User</h1>
        <p className="heading__credits"></p>
      </div>
      <UserForm handleOnSubmit={handleOnSubmit} />
    </>
  );
};

export default AddNewUser;
