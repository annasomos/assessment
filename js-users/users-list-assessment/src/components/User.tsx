import { UserModel } from "../model/UserModel";
import { useNavigate } from "react-router-dom";
import { useState, useEffect } from "react";
import { api } from "../api/api";

interface UserProps {
  user: UserModel;
}

const User: React.FC<UserProps> = ({
  user: { id, first_name, last_name, created_at, status },
}: UserProps) => {
  const navigate = useNavigate();
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
        <div className="card card-user">
          <div className="card__icon">
            <i className="fas fa-user-circle"></i>
          </div>
            {userStatus==="active" ? (<>
              <button className="card__active" onClick={() => updateStatus(id)}>
            <i className="fas fa-lock"></i>
            </button>
          <h2 className="card__title">
            {first_name} {last_name} ({created_at})
          </h2> </>) : (<>
            <button className="card__locked" onClick={() => updateStatus(id)}>
            <i className="fas fa-lock-open"></i>
            </button>
          <del><h2 className="card__title">
            {first_name} {last_name} ({created_at})
          </h2></del>
          </>)}
          <p className="card__apply">
            <button className="card__link" onClick={() => navigate(`/edit/${id}`)}>
              Edit User <i className="fas fa-pencil-alt"></i>
            </button>
          </p>
        </div>
  );
};

export default User;
