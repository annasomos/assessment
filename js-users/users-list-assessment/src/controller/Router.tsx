import { Routes, Route} from 'react-router-dom';
import App from "../App";
import EditUser from '../components/EditUser';
import UserList from "../components/UserList"



const Router = () => {
  return (
    <Routes>
      <Route element={<App />}>
      <Route index element={<UserList />} />
      <Route path="/edit/:id" element={<EditUser/>} />
      </Route>
    </Routes>
);
};

export default Router;