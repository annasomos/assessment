import { Link } from "react-router-dom";
import { useState } from "react";
import {
  MDBContainer,
  MDBNavbar,
  MDBNavbarNav,
  MDBNavbarLink,
} from "mdb-react-ui-kit";

const Navbar = () => {
  const [showNavSecond, setShowNavSecond] = useState(false);
  return (
    <nav>
      <MDBNavbar expand="lg" light bgColor="light">
        <MDBNavbarLink active aria-current="page">
          <Link to="/">Home</Link>
        </MDBNavbarLink>
        <MDBNavbarLink>
          <Link to="/new">Add New User</Link>
        </MDBNavbarLink>
      </MDBNavbar>
    </nav>
  );
};

export default Navbar;
