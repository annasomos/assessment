import { UserModel } from "../model/UserModel";
import { useState, useEffect } from "react";
import User from "../components/User";
import {
  MDBBtn,
  MDBPagination,
  MDBPaginationItem,
  MDBCard,
} from "mdb-react-ui-kit";

interface PaginationProps {
  users: UserModel[];
}

const UserPagination: React.FC<PaginationProps> = ({
  users,
}: PaginationProps) => {
  const shownUsersPerPage: number = 10;

  const numberOfPages: number = Math.ceil(users.length / shownUsersPerPage);

  const [currentPageNumber, setCurrentPageNumber] = useState<number>(1);

  const [currentPageUsers, setCurrentPageUsers] = useState<UserModel[]>();

  useEffect(() => {
    const startNumber = (currentPageNumber - 1) * shownUsersPerPage;
    const endNumber = startNumber + shownUsersPerPage;
    const usersPerCurrentPage = users.slice(startNumber, endNumber);
    setCurrentPageUsers(usersPerCurrentPage);
  }, [currentPageNumber, users]);

  function handlePreviousButtonClick() {
    setCurrentPageNumber((currentPageNum) => currentPageNum - 1);
  }

  function handleNextButtonClick() {
    setCurrentPageNumber((currentPageNum) => currentPageNum + 1);
  }

  function handlePageNumberClick(event: any) {
    const clickedPageNumber = parseInt(event.target.value);
    setCurrentPageNumber(clickedPageNumber);
  }

  function generatePageNumberArray(maxNumberOfPages: number): number[] {
    let pageNumbersShown = new Array();
    for (let number = 1; number <= maxNumberOfPages; number++) {
      pageNumbersShown = [...pageNumbersShown, number];
    }
    return pageNumbersShown;
  }

  return (
    <div className="container">
      <h1 className="heading__title">Users</h1>
      <MDBCard>
        <div className="cards">
          {currentPageUsers?.map((user) => (
            <User key={user.id} user={user} />
          ))}
        </div>
        <MDBPagination className="mb-0">
          <MDBPaginationItem>
            <MDBBtn
              disabled={currentPageNumber === 1}
              onClick={() => handlePreviousButtonClick()}
            >
              Previous Page
            </MDBBtn>
          </MDBPaginationItem>
          <MDBBtn
            disabled={currentPageNumber === numberOfPages}
            onClick={() => handleNextButtonClick()}
          >
            Next Page
          </MDBBtn>
        </MDBPagination>
        <div className="page-select" id="page-selector">
          <select onChange={handlePageNumberClick} value={currentPageNumber}>
            {generatePageNumberArray(numberOfPages).map((page) => {
              return <option value={page}>{page}</option>;
            })}
          </select>
          of {numberOfPages}
        </div>
      </MDBCard>
    </div>
  );
};

export default UserPagination;
