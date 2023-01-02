import { MDBCard } from "mdb-react-ui-kit";

const UserForm = ({ user, handleOnSubmit }: any) => {
  return (
    <MDBCard>
      <div className="user-form">
        <form onSubmit={handleOnSubmit}>
          <div className="mb-5">
            <label className="name-label">First Name:</label>
            <input
              required={true}
              maxLength={15}
              type="text"
              placeholder="First Name"
              name="first_name"
              defaultValue={user?.first_name}
            />
          </div>
          <div className="mb-5">
            <label className="name-label">Last Name:</label>
            <input
              required={true}
              maxLength={15}
              type="text"
              placeholder="Last Name"
              name="last_name"
              defaultValue={user?.last_name}
            />
          </div>
          <button type="submit">Submit</button>
        </form>
      </div>
    </MDBCard>
  );
};

export default UserForm;
