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
                      <button className="card__edit" onClick={() => navigate(`/edit/${id}`)}>
              Edit <i className="fas fa-pencil-alt"></i>
            </button>
            {userStatus==="active" ? (<>
              <button className="card__active" onClick={() => updateStatus(id)}>
            <i className="bi bi-lock"></i>
            </button>
          <h2 className="card__title">
            {first_name} {last_name} ({created_at})
          </h2> </>) : (<>
            <button className="card__locked" onClick={() => updateStatus(id)}>
            <i className="bi bi-unlock"></i>
            </button>
          <del><h2 className="card__edit">
            {first_name} {last_name} ({created_at})
          </h2></del>
          </>)}
        </div>
  );
};

export default User;
