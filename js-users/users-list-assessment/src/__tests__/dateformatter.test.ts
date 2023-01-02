import { formatDate } from "../util/dateformatter";

test("2022-12-12T00:26:59.746Z === 2022-12-12 00:26", () => {
  expect(formatDate("2022-12-12T00:26:59.746Z")).toBe("2022-12-12 00:26");
});

test("2022-12-07T08:17:07.918Z === 2022-12-07 08:17", () => {
  expect(formatDate("2022-12-07T08:17:07.918Z")).toBe("2022-12-07 08:17");
});
