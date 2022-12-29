import { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { api } from "../api/api";
import { UserModel } from "../model/UserModel";

export const EditUser = () => {
  const [user, setUser] = useState<UserModel>();

  const [isUserFound, setIsUserFound] = useState<boolean>(false);

  const [errorMessage, setErrorMessage] = useState<string>("User Not Found");

  const navigateTo = useNavigate();

  const params = useParams();

  const[userId, setUserId] = useState<string>(params.id as string);

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

  async function updateUser(event: any) {
    event.preventDefault();
    const updatedUser: updatedUser = {
      first_name: event.target["first_name"].value,
      last_name: event.target["last_name"].value,
    };
    await api.updateUserById(userId, updatedUser);
    navigateTo("../", { replace: true });
  }

  return (
    <div className="edit-container">
      {isUserFound ? (
        <div className="edit-form">
          <form onSubmit={(event) => updateUser(event)}>
            <div className="edit-row">
              <label>First Name:</label>
              <input
                required={true}
                type="text"
                placeholder="First Name"
                name="first_name"
                defaultValue={user?.first_name}
              />
            </div>
            <div className="edit-row">
              <label>Last Name:</label>
              <input
                required={true}
                type="text"
                placeholder="Last Name"
                name="last_name"
                defaultValue={user?.last_name}
              />
            </div>
            <button type="submit">Submit</button>
          </form>
        </div>
      ) : (
        <div className="error-container">{errorMessage}</div>
      )}
    </div>
  );
};

export default EditUser;
