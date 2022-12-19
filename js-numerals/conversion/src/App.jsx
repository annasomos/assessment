import ConverterForm from "./components/ConverterForm";

function App() {
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
      <ConverterForm />
    </div>
  );
}

export default App;
