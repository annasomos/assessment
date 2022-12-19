import { useMemo } from "react";
import { convertNumber, britishConversion } from "./conversion";

const ConvertedNumber = ({ number }) => {
  const converted = useMemo(() => {
    return number || number === 0 ? convertNumber(number) : number;
  }, [number]);

  const britishConverted = useMemo(() => {
    return number || number === 0 ? britishConversion(number) : number;
  }, [number]);

  const isBritishNeeded = useMemo(() => {
    if (Math.abs(number) > 1000 && Math.abs(number) < 2000) {
      return true;
    }
    return false;
  }, [number]);

  return (
    <>
      <div className="result">
        Your number converted to English words is: {converted}
      </div>
      {isBritishNeeded ? (
        <div className="result">
          ...or as the British would say: {britishConverted}
        </div>
      ) : (
        ""
      )}
    </>
  );
};

export default ConvertedNumber;
