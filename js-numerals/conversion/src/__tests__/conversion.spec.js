import { convertNumber, britishConversion } from "../utils/conversion";

test("7 === seven", () => {
  expect(convertNumber(7)).toBe("seven");
  expect(britishConversion(7)).toBe("seven");
});

test("-7 === negative seven", () => {
  expect(convertNumber(-7)).toBe("negative seven");
  expect(britishConversion(-7)).toBe("negative seven");
});

test("42 === forty-two", () => {
  expect(convertNumber(42)).toBe("forty-two");
  expect(britishConversion(42)).toBe("forty-two");
});

test("-42 === negative forty-two", () => {
  expect(convertNumber(-42)).toBe("negative forty-two");
  expect(britishConversion(-42)).toBe("negative forty-two");
});

test("1999 === one thousand nine hundred and ninety-nine", () => {
  expect(convertNumber(1999)).toBe("one thousand nine hundred and ninety-nine");
});

test("-1999 === negativeone thousand nine hundred and ninety-nine", () => {
  expect(convertNumber(-1999)).toBe(
    "negative one thousand nine hundred and ninety-nine"
  );
});

test("1999 === nineteen hundred and ninety-nine", () => {
  expect(britishConversion(1999)).toBe("nineteen hundred and ninety-nine");
});

test("-1999 === negative nineteen hundred and ninety-nine", () => {
  expect(britishConversion(-1999)).toBe(
    "negative nineteen hundred and ninety-nine"
  );
});

test("1003 === ten hundred and three", () => {
  expect(britishConversion(1003)).toBe("ten hundred and three");
});

test("1003 === one thousand and three", () => {
  expect(convertNumber(1003)).toBe("one thousand and three");
});

test("1011 === one thousand and eleven", () => {
  expect(convertNumber(1011)).toBe("one thousand and eleven");
});

test("1011 === ten hundred and eleven", () => {
  expect(britishConversion(1011)).toBe("ten hundred and eleven");
});

test("1230 === twelve hundred and thirty", () => {
  expect(britishConversion(1230)).toBe("twelve hundred and thirty");
});

test("1230 === one thousand two hundred and thirty", () => {
  expect(convertNumber(1230)).toBe("one thousand two hundred and thirty");
});

test("2001 === two thousand and one", () => {
  expect(convertNumber(2001)).toBe("two thousand and one");
});

test("-2001 === negative two thousand and one", () => {
  expect(convertNumber(-2001)).toBe("negative two thousand and one");
});

test("17999 === seventeen thousand nine hundred and ninety-nine", () => {
  expect(convertNumber(17999)).toBe(
    "seventeen thousand nine hundred and ninety-nine"
  );
});

test("-17999 === negative seventeen thousand nine hundred and ninety-nine", () => {
  expect(convertNumber(-17999)).toBe(
    "negative seventeen thousand nine hundred and ninety-nine"
  );
});

test("100001 === one hundred thousand and one", () => {
  expect(convertNumber(100001)).toBe("one hundred thousand and one");
});

test("-100001 === negative one hundred thousand and one", () => {
  expect(convertNumber(-100001)).toBe("negative one hundred thousand and one");
});

test("342251  === three hundred and forty-two thousand two hundred and fifty-one", () => {
  expect(convertNumber(342251)).toBe(
    "three hundred and forty-two thousand two hundred and fifty-one"
  );
});

test("-342251  === negative three hundred and forty-two thousand two hundred and fifty-one", () => {
  expect(convertNumber(-342251)).toBe(
    "negative three hundred and forty-two thousand two hundred and fifty-one"
  );
});

test("1300420 === one million three hundred thousand four hundred and twenty", () => {
  expect(convertNumber(1300420)).toBe(
    "one million three hundred thousand four hundred and twenty"
  );
});

test("-1300420 === negative one million three hundred thousand four hundred and twenty", () => {
  expect(convertNumber(-1300420)).toBe(
    "negative one million three hundred thousand four hundred and twenty"
  );
});

test("0 === zero", () => {
  expect(convertNumber(0)).toBe("zero");
});

test("999999999 === nine hundred and ninety-nine million nine hundred and ninety-nine thousand nine hundred and ninety-nine", () => {
  expect(convertNumber(999999999)).toBe(
    "nine hundred and ninety-nine million nine hundred and ninety-nine thousand nine hundred and ninety-nine"
  );
});

test("-999999999 === negative nine hundred and ninety-nine million nine hundred and ninety-nine thousand nine hundred and ninety-nine", () => {
  expect(convertNumber(-999999999)).toBe(
    "negative nine hundred and ninety-nine million nine hundred and ninety-nine thousand nine hundred and ninety-nine"
  );
});
