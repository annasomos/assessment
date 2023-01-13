import { Outlet } from "react-router-dom";
import "./App.css";
import Navbar from "./view/Navbar";
import UserProvider from "./context/UserContext";


function App() {

  return (
    <div className="container">
      <UserProvider>
      <Navbar />
      <Outlet />
      </UserProvider>
    </div>
  );
}

export default App;
