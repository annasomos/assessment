import { Routes, Route} from 'react-router-dom';
import App from "./App";
import UsersList from "./UsersList"
import AddNewUser from "./AddNewUser";
import EditUser from "./EditUser"


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