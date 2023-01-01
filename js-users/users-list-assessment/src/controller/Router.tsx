import { Routes, Route } from "react-router-dom";
import App from "../App";
import AddNewUser from "../components/AddNewUser";
import EditUser from "../components/EditUser";
import UserList from "../components/UserList";

const Router = () => {
  return (
    <Routes>
      <Route element={<App />}>
        <Route index element={<UserList />} />
        <Route path="/edit/:id" element={<EditUser />} />
        <Route path="/new" element={<AddNewUser />} />
      </Route>
    </Routes>
  );
};

export default Router;
