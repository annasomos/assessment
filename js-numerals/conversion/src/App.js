import { useState } from "react";
import ConvertedNumber from "./ConvertedNumber";

function App() {
  const [number, setNumber] = useState();

  const handleNumberInputChange = (e) => {
    const { target: { value } } = e;

    if(value){
      setNumber(Math.round(Number(value)));
    } else {
      setNumber();
    }
  }

  return (
    <div className="App">
      <div className="container">
      <input
        type="number"
        className="input"
        id="number"
        placeholder="Enter a number"
        onChange={handleNumberInputChange}
      ></input>
      <ConvertedNumber number={number} />
      </div>
    </div>
  );
}

export default App;
