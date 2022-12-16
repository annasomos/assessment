import { convertNumber } from "./conversion"
import { britishConversion } from "./conversion"

const ConvertedNumber = ({number}) => {
  return (
    <>
      <div>Your number converted to English words is: {convertNumber(number)}</div>
      <div>...or as the British would say: {(number <= 2000 && number >=1000) ? britishConversion(number) : ''}</div>
    </>    
  )
}

export default ConvertedNumber