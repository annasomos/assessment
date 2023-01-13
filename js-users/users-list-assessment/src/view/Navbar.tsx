import { Link } from "react-router-dom";
import { useState } from "react";
import {
  MDBContainer,
  MDBNavbar,
  MDBNavbarNav,
  MDBNavbarToggler,
  MDBCollapse,
  MDBNavbarItem,
  MDBNavbarBrand,
  MDBIcon,
  MDBBtn
} from "mdb-react-ui-kit";

const Navbar = () => {
  const [showNavSecond, setShowNavSecond] = useState(false);

  return (
    <MDBNavbar expand="lg" light bgColor="light">
      <MDBContainer fluid>
        <MDBNavbarBrand>USER LIST APP</MDBNavbarBrand>
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
              <button className="btn-menu">
              <Link reloadDocument to="/">
                Home
              </Link>
              </button>
            </MDBNavbarItem>
            <MDBNavbarItem>
              <button className="btn-menu">
              <Link to="/new">Add New User </Link>
              </button>
            </MDBNavbarItem>
          </MDBNavbarNav>
        </MDBCollapse>
      </MDBContainer>
    </MDBNavbar>
  );
};

export default Navbar;
