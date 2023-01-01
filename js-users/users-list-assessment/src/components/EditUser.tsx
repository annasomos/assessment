import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { api } from "../api/api";
import { UserModel } from "../model/UserModel";
import UserForm from "./UserForm";
import {
  MDBCardBody,
  MDBCardTitle,
  MDBCardText,
  MDBCard,
} from "mdb-react-ui-kit";

export const EditUser = () => {
  const [user, setUser] = useState<UserModel>();

  const [isUserFound, setIsUserFound] = useState<boolean>(false);

  const [errorMessage, setErrorMessage] = useState<string>("User Not Found");

  const navigateTo = useNavigate();

  const params = useParams();

  const [userId, setUserId] = useState<string>(params.id as string);

  type updatedUser = {
    first_name: string;
    last_name: string;
  };

  useEffect(() => {
    const getUserById = async () => {
      try {
        setIsUserFound(true);
        return await api.getUserById(userId);
      } catch (error) {
        setIsUserFound(false);
      }
    };

    getUserById().then((user) => {
      setUser(user);
    });
  }, [params.id]);

  const handleOnSubmit = async (event: any) => {
    event.preventDefault();
    const updatedUser: updatedUser = {
      first_name: event.target["first_name"].value,
      last_name: event.target["last_name"].value,
    };
    await api.updateUserById(userId, updatedUser);
    navigateTo("../");
  };

  return (
      <MDBCard>
      <MDBCardBody>
      <MDBCardTitle>Edit User {user?.id}</MDBCardTitle>
      <MDBCardText>
      {isUserFound ? (
        <UserForm user={user} handleOnSubmit={handleOnSubmit} />
      ) : (
        errorMessage
      )}</MDBCardText>
      </MDBCardBody>
      </MDBCard>
  );
};

export default EditUser;
