import './App.css';
import {useState} from 'react';
import ConvertedNumber from './ConvertedNumber';

function App() {
const [number,setNumber] = useState(0);

  return (
    <div className="App">
      <input type="number" className="input" id="number" placeholder="Enter a number" onChange={(e) => setNumber(parseInt(e.target.value))}></input>
      <ConvertedNumber number={number} />
    </div>
  );
}

export default App;
