import { Routes, Route} from 'react-router-dom';
import App from "../App";
import UsersList from "../components/UsersList"
import AddNewUser from "../components/AddNewUser";
import EditUser from "../components/EditUser"


const Router = () => {
  return (
    <Routes>
      <Route element={<App />}>
      <Route index element={<UsersList />} />
        <Route path="/new" element={<AddNewUser/>}/>
        <Route path="/edit/:id" element={<EditUser/>} />
      </Route>
    </Routes>
);
};

export default Router;