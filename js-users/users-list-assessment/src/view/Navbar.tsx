import { Link } from "react-router-dom";
import { useState } from "react";
import {
  MDBContainer,
  MDBNavbar,
  MDBNavbarNav,
  MDBNavbarLink,
  MDBNavbarToggler,
  MDBCollapse,
  MDBNavbarItem,
  MDBNavbarBrand,
  MDBIcon,
} from "mdb-react-ui-kit";


const Navbar = () => {
  const [showNavSecond, setShowNavSecond] = useState(false);

  return (
    <MDBNavbar expand="lg" light bgColor="light">
      <MDBContainer fluid>
        <MDBNavbarBrand>User List</MDBNavbarBrand>
        <MDBNavbarToggler
          type="button"
          aria-expanded="false"
          aria-label="Toggle navigation"
          onClick={() => setShowNavSecond(!showNavSecond)}
        >
          <MDBIcon icon="bars" fas />
        </MDBNavbarToggler>
        <MDBCollapse navbar show={showNavSecond}>
          <MDBNavbarNav>
            <MDBNavbarItem>
                <Link reloadDocument to="/">Home </Link>
            </MDBNavbarItem>
            <MDBNavbarItem>
                <Link to="/new">Add New User </Link>
            </MDBNavbarItem>
          </MDBNavbarNav>
        </MDBCollapse>
      </MDBContainer>
    </MDBNavbar>
  );
};

export default Navbar;
