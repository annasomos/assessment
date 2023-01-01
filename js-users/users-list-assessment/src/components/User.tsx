import { UserModel } from "../model/UserModel";
import { useNavigate } from "react-router-dom";
import { useState, useEffect } from "react";
import { api } from "../api/api";
import {
  MDBCard,
  MDBCardBody,
  MDBCardTitle,
  MDBCardText,
  MDBBtn
} from 'mdb-react-ui-kit';


interface UserProps {
  user: UserModel;
}

const User: React.FC<UserProps> = ({
  user: { id, first_name, last_name, created_at, status },
}: UserProps) => {
  const navigateTo = useNavigate();
  const [userStatus, setUserStatus] = useState<string>(status);

  async function updateStatus(id: number) {
    const status = userStatus === "active" ? "locked" : "active";
    const statusUpdate = {
      status: status,
    };
    try {
      await api.updateStatusById(id, statusUpdate);
      setUserStatus(status);
    } catch (error) {
      console.log(error);
    }
  }

  return (<MDBCard className="p-3 mb-2 bg-dark bg-gradient text-white rounded-5">
    <MDBCardBody>
      <MDBCardTitle>{userStatus === "active" ? (`${first_name}`) : (<del>{first_name}</del>)}</MDBCardTitle>
      <MDBCardTitle>{userStatus === "active" ? (`${last_name}`) : (<del>{last_name}</del>)}</MDBCardTitle>
      <MDBCardText>Created at: {created_at}</MDBCardText>
      <MDBBtn onClick={() => updateStatus(id)}>{userStatus === "active" ? "Lock" : "Unlock"}</MDBBtn>
      <MDBBtn onClick={() => navigateTo(`/edit/${id}`)}>Edit</MDBBtn>
    </MDBCardBody>
  </MDBCard>);
};

export default User;
