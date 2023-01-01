import {Outlet} from "react-router-dom";
import './App.css'
import Navbar from './view/Navbar'
import {MDBCard} from "mdb-react-ui-kit";

function App() {

  return (
    <MDBCard>
      <Navbar />
      <Outlet />
    </MDBCard>
  )
}

export default App;
