import {useState} from "react";


export const EditUser = () => {

const [isUserFound, setIsUserFound] = useState<boolean>(true);

type updatedUser = {
  first_name: string;
  last_name: string;
}

  return (
    <div>EditUser</div>
  )
}

export default EditUser;