import "./App.css";
import { useState } from "react";
import ConvertedNumber from "./ConvertedNumber";

function App() {
  const [number, setNumber] = useState();

  const handleNumberInputChange = (e) => {
    const { target: { value } } = e;

    if(value){
      setNumber(Number(value));
    } else {
      setNumber();
    }
  }

  return (
    <div className="App">
      <input
        type="number"
        className="input"
        id="number"
        placeholder="Enter a number"
        onChange={handleNumberInputChange}
      ></input>
      <ConvertedNumber number={number} />
    </div>
  );
}

export default App;
