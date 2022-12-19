import ConvertedNumber from "./ConvertedNumber";
import { useState } from "react";

const ConverterForm = () => {
  const [number, setNumber] = useState();

  const handleNumberSubmit = (e) => {
    e.preventDefault();
    const inputValue = document.getElementById("number").value;
    const numericValue = Math.round(Number(inputValue));

    if (inputValue) {
      Math.abs(numericValue) <= 999999999
        ? setNumber(numericValue)
        : setNumber();
    } else {
      setNumber();
    }
  };

  return (
    <div className="container">
      <form className="input">
        <input
          type="number"
          className="number-input"
          id="number"
          placeholder="Enter a number"
        ></input>
        <button
          type="submit"
          className="number-submit-button"
          onClick={handleNumberSubmit}
        >
          Convert
        </button>
      </form>
      <ConvertedNumber number={number} />
    </div>
  );
};

export default ConverterForm;
