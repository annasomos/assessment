import { useState, useEffect, useContext } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { api } from "../api/api";
import { UserModel } from "../model/UserModel";
import UserForm from "./UserForm";
import { UserContext } from "../context/UserContext";
import { MDBCardBody, MDBCardTitle, MDBCard } from "mdb-react-ui-kit";

export const EditUser = () => {
  const { setAllUsers } = useContext(UserContext);

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

  const handleUpdateOnSubmit = async (event: any) => {
    event.preventDefault();
    const updatedUser: updatedUser = {
      first_name: event.target["first_name"].value,
      last_name: event.target["last_name"].value,
    };
    await api.updateUserById(userId, updatedUser);
    const refreshedUsers = await api.getAllUsers();
    setAllUsers(refreshedUsers);
    navigateTo("../");
  };

  return (
    <MDBCard>
      <MDBCardBody>
        <MDBCardTitle>Edit User {user?.id}</MDBCardTitle>
        {isUserFound ? (
          <UserForm user={user} handleOnSubmit={handleUpdateOnSubmit} />
        ) : (
          errorMessage
        )}
      </MDBCardBody>
    </MDBCard>
  );
};

export default EditUser;
