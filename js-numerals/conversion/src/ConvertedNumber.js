import { convertNumber } from "./conversion"

const ConvertedNumber = ({number}) => {
  return (
    <div>{convertNumber(number)}</div>
  )
}

export default ConvertedNumber