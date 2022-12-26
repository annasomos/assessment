import { Routes, Route} from 'react-router-dom';
import App from "../App";
import UserList from "../components/UserList"



const Router = () => {
  return (
    <Routes>
      <Route element={<App />}>
      <Route index element={<UserList />} />
      </Route>
    </Routes>
);
};

export default Router;