import {Link} from "react-router-dom";

const Navbar = () => {
  return (
    <header>
      <div
        className="navigation-menu">
        <ul>
          <li>
          <Link to={"/"}>Home</Link>
          </li>
          <li>
          <Link to={"/new"}>Add User</Link>
          </li>
        </ul>
      </div>
    </header>
  )
}

export default Navbar