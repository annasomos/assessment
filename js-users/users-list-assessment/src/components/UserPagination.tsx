import { UserModel } from "../model/UserModel";
import { useState, useEffect } from "react";

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

  const [maxPagesShown, setMaxPagesShown] = useState<number>(3);

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


  return <></>;
};

export default UserPagination;
