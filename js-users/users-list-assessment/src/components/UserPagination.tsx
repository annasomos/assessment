import { UserModel } from "../model/UserModel";
import { useState, useEffect } from "react";
import User from "../components/User";
import {
  MDBBtn,
  MDBPagination,
  MDBPaginationItem,
  MDBCardBody,
  MDBIcon,
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
      <h2>Users</h2>
      <MDBCardBody>
        {currentPageUsers?.map((user) => (
          <User key={user.id} user={user} />
        ))}
        <MDBPagination className="mb-0">
          <MDBPaginationItem>
            <MDBBtn
              disabled={currentPageNumber === 1}
              onClick={() => handlePreviousButtonClick()}
            >
              <MDBIcon fas icon="angle-double-left" />
            </MDBBtn>
          </MDBPaginationItem>
          <MDBPaginationItem>
            <div className="page-select" id="page-selector">
              <select
                className="page-selector"
                onChange={handlePageNumberClick}
                value={currentPageNumber}
              >
                {generatePageNumberArray(numberOfPages).map((page) => {
                  return (
                    <option value={page} key={page}>
                      {page}
                    </option>
                  );
                })}
              </select>
              of {numberOfPages}
            </div>
          </MDBPaginationItem>
          <MDBPaginationItem>
            <MDBBtn
              disabled={currentPageNumber === numberOfPages}
              onClick={() => handleNextButtonClick()}
            >
              <MDBIcon fas icon="angle-double-right" />
            </MDBBtn>
          </MDBPaginationItem>
        </MDBPagination>
      </MDBCardBody>
    </div>
  );
};

export default UserPagination;
