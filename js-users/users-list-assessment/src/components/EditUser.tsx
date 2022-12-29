import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { api } from "../api/api";
import { UserModel } from "../model/UserModel";
import UserForm from "./UserForm";

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
    <div className="edit-container">
      <div className="heading">
        <h1 className="heading__title">Edit User {user?.id}</h1>
        <p className="heading__credits"></p>
      </div>
      {isUserFound ? (
        <UserForm user={user} handleOnSubmit={handleOnSubmit} />
      ) : (
        <div className="error-container">{errorMessage}</div>
      )}
    </div>
  );
};

export default EditUser;
