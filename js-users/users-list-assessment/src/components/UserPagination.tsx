import { UserModel } from "../model/UserModel";
import { useState, useEffect } from "react";
import User from "../components/User";

interface PaginationProps {
  users: UserModel[];
}

const UserPagination: React.FC<PaginationProps> = ({
  users,
}: PaginationProps) => {
  const shownUsersPerPage: number = 10;

  const numberOfPages: number = Math.ceil(users.length / shownUsersPerPage);

  const [pageNumbers, setPageNumbers] = useState<number[]>();

  const [minPagesShown, setMinPagesShown] = useState<number>(0);

  const [maxPagesShown, setMaxPagesShown] = useState<number>(5);

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
    setMinPagesShown((currentNumber) => currentNumber - 1);
    setMaxPagesShown((currentNumber) => currentNumber - 1);
  }

  function handleNextButtonClick() {
    setCurrentPageNumber((currentPageNum) => currentPageNum + 1);
    setMinPagesShown((currentNumber) => currentNumber + 1);
    setMaxPagesShown((currentNumber) => currentNumber + 1);
  }

  function handlePageNumberClick(event: any) {
    const clickedPageNumber = parseInt(event.target.innerHTML);
    setCurrentPageNumber(clickedPageNumber);
    const pageNumber: number =
      currentPageNumber > clickedPageNumber
        ? currentPageNumber - clickedPageNumber
        : clickedPageNumber - currentPageNumber;

    clickedPageNumber > currentPageNumber
      ? increaseMinAndMaxPagesShown(pageNumber)
      : decreaseMinAndMaxPagesShown(pageNumber);
  }

  function decreaseMinAndMaxPagesShown(decrement: number) {
    setMinPagesShown((currentNumber) => currentNumber - decrement);
    setMaxPagesShown((currentNumber) => currentNumber - decrement);
  }

  function increaseMinAndMaxPagesShown(increment: number) {
    setMinPagesShown((currentNumber) => currentNumber + increment);
    setMaxPagesShown((currentNumber) => currentNumber + increment);
  }

  function generatePageNumberArray(maxNumberOfPages: number) {
    let pageNumbersShown = new Array();
    for (let number = 1; number <= maxNumberOfPages; number++) {
      pageNumbersShown = [...pageNumbersShown, number];
    }
    return pageNumbersShown;
  }

  useEffect(() => setPageNumbers(generatePageNumberArray(numberOfPages)), [currentPageNumber]);

  return (
<div className="">
    <div className="main-container">
      <div className="heading">
        <h1 className="heading__title">All Users</h1>
      </div>
      <div className="cards">
      {currentPageUsers?.map((user) => (
          <User key={user.id} user={user} />
        ))}
      </div>
    </div>
    <div>
    <button
      disabled={currentPageNumber === 1}
      onClick={() => handlePreviousButtonClick()}
    >
      Previous Page
    </button>
    <div className="flex flex-row justify-center">
          {pageNumbers?.map((pageNumber) => {
            if (pageNumber <= maxPagesShown && pageNumber > minPagesShown) {
              return (
                <li
                  key={pageNumber}
                  onClick={(event) => handlePageNumberClick(event)}
                  className="list-none mt-2 mr-8 bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-1 px-2 border border-blue-500 hover:border-transparent rounded"
                >
                  {pageNumber}
                </li>
              );
            }
          })}
        </div>
    <button
      disabled={currentPageNumber === numberOfPages}
      onClick={() => handleNextButtonClick()}
    >
      Next Page
    </button>
  </div>
  </div>
  );
};

export default UserPagination;
