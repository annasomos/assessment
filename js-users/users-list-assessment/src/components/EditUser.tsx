import {useState, useEffect} from "react";
import {useNavigate, useParams} from "react-router-dom";
import { api } from "../api/api";
import { UserModel } from "../model/UserModel";


export const EditUser = () => {

const [user, setUser] = useState<UserModel>();

const [isUserFound, setIsUserFound] = useState<boolean>(true);

const [errorMessage, setErrorMessage] = useState<string>()

const navigateTo = useNavigate();

const params = useParams();

type updatedUser = {
  first_name: string;
  last_name: string;
}

useEffect(() => {
  const getUserById = async () => {
    try {
      return await api.getUserById(params.id as string);
    } catch (error) {
      setIsUserFound(false)
      setErrorMessage("User Not Found")
    } 
  };

  getUserById().then((user) => {
    setUser(user);
  });
}, [params.id]);

  return (
    <div className="edit-form">
      <form>
      <label>
              First Name:
      </label>
            <input
              required={true}
              type="text"
              placeholder="First Name"
              name="first_name"
              defaultValue={user?.first_name}
            />
            <label>
              Last Name:
      </label>
            <input
              required={true}
              type="text"
              placeholder="Last Name"
              name="last_name"
              defaultValue={user?.last_name}
            />
      </form>
    </div>
  )
}

export default EditUser;