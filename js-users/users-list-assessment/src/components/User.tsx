import { UserModel } from "../model/UserModel";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import { api } from "../api/api";
import { formatDate } from "../util/dateformatter";
import {
  MDBCard,
  MDBCardBody,
  MDBCardTitle,
  MDBCardText,
  MDBBtn,
  MDBIcon,
  MDBRow,
} from "mdb-react-ui-kit";

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

  return (
    <MDBRow>
      <MDBCard shadow="0" border="info" background="white" className="mb-3">
        <MDBCardBody>
          <MDBCardTitle>
            {userStatus === "active" ? (
              `${first_name}`
            ) : (
              <del>{first_name}</del>
            )}
          </MDBCardTitle>
          <MDBCardTitle>
            {userStatus === "active" ? `${last_name}` : <del>{last_name}</del>}
          </MDBCardTitle>
          <MDBCardText>Created at: {formatDate(created_at)}</MDBCardText>
          <MDBBtn onClick={() => updateStatus(id)} className="btn-grad">
            {userStatus === "active" ? (
              <i>
                Lock <MDBIcon fas icon="lock" />
              </i>
            ) : (
              <i>
                Unlock <MDBIcon fas icon="lock-open" />
              </i>
            )}
          </MDBBtn>
          <MDBBtn
            onClick={() => navigateTo(`/edit/${id}`)}
            className="btn-grad"
          >
            Edit <MDBIcon fas icon="user-edit" />
          </MDBBtn>
        </MDBCardBody>
      </MDBCard>
    </MDBRow>
  );
};

export default User;
