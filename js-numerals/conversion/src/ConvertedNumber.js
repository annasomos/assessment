import { useMemo } from "react"
import { convertNumber, britishConversion } from "./conversion"

const ConvertedNumber = ({number}) => {
  const converted = useMemo(() => {
    return number ? convertNumber(number) : number;
  }, [number])

  const britishConverted = useMemo(() => {
    return number ? britishConversion(number): number;
  }, [number])

  return (
    <>
      <div>Your number converted to English words is: {converted}</div>
      <div>As the British would say: {britishConverted}</div>
    </>    
  )
}

export default ConvertedNumber