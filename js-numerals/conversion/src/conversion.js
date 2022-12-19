const ones = [
  "",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
];
const tens = [
  "",
  "ten",
  "twenty",
  "thirty",
  "forty",
  "fifty",
  "sixty",
  "seventy",
  "eighty",
  "ninety",
];
const teens = [
  "ten",
  "eleven",
  "twelve",
  "thirteen",
  "fourteen",
  "fifteen",
  "sixteen",
  "seventeen",
  "eighteen",
  "nineteen",
];

function convertMillions(num) {
  if (num >= 1000000) {
    return `${convertMillions(
      Math.floor(num / 1000000)
    )} million ${convertThousands(num % 1000000)}`;
  }
  return convertThousands(num);
}

function convertThousands(num) {
  if (num >= 1000) {
    return `${convertHundreds(Math.floor(num / 1000))} thousand ${
      num % 1000 > 100 || num % 1000 === 0 ? "" : " and "
    }${convertHundreds(num % 1000)}`;
  }
  return convertHundreds(num);
}

function convertHundreds(num) {
  if (num > 99) {
    return `${ones[Math.floor(num / 100)]} hundred ${
      num % 10 === 0 ? "" : " and "
    } ${convertTens(num % 100)}`;
  }
  return convertTens(num);
}

function convertTens(num) {
  if (num < 10) return ones[num];
  else if (num >= 10 && num < 20) return teens[num - 10];
  return `${tens[Math.floor(num / 10)]}${num % 10 === 0 ? "" : "-"}${
    ones[num % 10]
  }`;
}

export function convertNumber(num) {
  if (num === 0) return "zero";
  else if (num < 0) {
    return `negative ${convertMillions(-num)}`;
  }
  return convertMillions(num);
}

export function britishConversion(num) {
  if (num < 2000 && num > 1000) {
    return `${convertHundreds(Math.floor(num / 100))} hundred ${
      num % 100 === 0 ? "" : "and "
    }${convertTens(num % 100)}`;
  } else if (num <= -1000 && num >= -2000) {
    return `negative ${convertHundreds(Math.floor(-num / 100))} hundred ${
      num % 100 === 0 ? "" : "and "
    }${convertTens(-num % 100)}`;
  }
  return convertNumber(num);
}
