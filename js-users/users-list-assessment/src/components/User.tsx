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
      {userStatus === "active" ? (
        <h2 className="card__title">
          {first_name} {last_name} <p>({created_at})</p>
        </h2>
      ) : (
        <del>
          <h2 className="card__title">
            {first_name} {last_name} <p>{created_at}</p>
          </h2>
        </del>
      )}{" "}
      {userStatus === "active" ? (
        <button className="card__active" onClick={() => updateStatus(id)}>
          <i className="bi bi-lock"></i>
          Lock
        </button>
      ) : (
        <button className="card__locked" onClick={() => updateStatus(id)}>
          <i className="bi bi-unlock"></i>
          Unlock
        </button>
      )}
      <button className="card__edit" onClick={() => navigate(`/edit/${id}`)}>
        Edit <i className="bi bi-pencil-square"></i>
      </button>
    </div>
  );
};

export default User;
