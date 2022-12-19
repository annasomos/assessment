import { useState } from "react";
import ConvertedNumber from "./ConvertedNumber";

function App() {
  const [number, setNumber] = useState();

  const handleNumberSubmit = (e) => {
    e.preventDefault();
    const inputValue = document.getElementById("number").value;
    const numericValue = Math.round(Number(inputValue));

    if (inputValue) {
      (numericValue >= -999999999 && numericValue <= 999999999) ? setNumber(numericValue) : setNumber();
    } else {
      setNumber();
    }
  };

  return (
    <div className="App">
      <div className="intro">
        <h1>Arabic Number Converter</h1>
        <p>
          Enter a number between -999999999 and +999999999 to convert it into
          English words! Please note that fractions will be rounded, and only
          numeric values are allowed.
        </p>
      </div>
      <div className="container">
        <form className="input">
          <input type="number" id="number" placeholder="Enter a number"></input>{" "}
          <button type="submit" onClick={handleNumberSubmit}>
            Convert
          </button>
        </form>
        <ConvertedNumber number={number} />
      </div>
    </div>
  );
}

export default App;
