import {useState, useEffect, createContext} from "react"
import { UserModel } from "../model/UserModel";
import { api } from "../api/api";
import { MDBSpinner } from "mdb-react-ui-kit";


export const UserContext = createContext<UserModel[]>([]);


export const UserProvider = ({children}: any) => {

  const [allUsers, setAllUsers] = useState<UserModel[] | null>(null);

  async function getUsers() {
    const users = await api.getAllUsers();
    setAllUsers(users);
  }

  useEffect(() => {
    getUsers();
  }, []);

  if(allUsers === null){
    return (<MDBSpinner className="m-5" role="status">
    <span className="visually-hidden">Loading...</span>
  </MDBSpinner>)
  }

  return (
    <UserContext.Provider value={allUsers}>
      {children}
    </UserContext.Provider>
  )
}

export default UserProvider;