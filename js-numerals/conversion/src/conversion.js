const ones = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
const tens = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];
const teens = ['ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'];

function convertMillions(num) {
  if (num >= 1000000) {
    return convertMillions(Math.floor(num / 1000000)) + " million " + convertThousands(num % 1000000);
  } else {
    return convertThousands(num);
  }
}

function convertThousands(num) {
  if (num >= 1000) {
    return convertHundreds(Math.floor(num / 1000)) + " thousand " + convertHundreds(num % 1000);
  } else {
    return convertHundreds(num);
  }
}

function convertHundreds(num) {
  if (num > 99) {
    return ones[Math.floor(num / 100)] + " hundred " + convertTens(num % 100);
  } else {
    return convertTens(num);
  }
}

function convertTens(num) {
  if (num < 10) return ones[num];
  else if (num >= 10 && num < 20) return teens[num - 10];
  else {
    return tens[Math.floor(num / 10)] + " " + ones[num % 10];
  }
}

function convertNumber(num) {
  if (num === 0) return "zero";
  else return convertMillions(num);
}