import { useState } from "react";
import ConvertedNumber from "./ConvertedNumber";

function App() {
  const [number, setNumber] = useState();

  const handleNumberInputChange = (e) => {
    const {
      target: { value },
    } = e;

    if (value) {
      setNumber(Math.round(Number(value)));
    } else {
      setNumber();
    }
  };

  return (
    <div className="App">
      <div className="intro">
        <h1>Arabic Number Converter</h1>
        <p>
          {" "}
          Enter a number between -999999999 and +999999999 to convert it into
          English words! Please note that fractions will be rounded, and only
          numeric values are allowed.
        </p>
      </div>
      <div className="container">
        <div className="input">
          <input
            type="number"
            id="number"
            placeholder="Enter a number"
            onChange={handleNumberInputChange}
          ></input>
        </div>
        <ConvertedNumber number={number} />
      </div>
    </div>
  );
}

export default App;
