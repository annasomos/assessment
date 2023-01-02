const dateStart: number = 0;
const dateEnd: number = 10;
const timeStart: number = 11;
const timeEnd: number = 16;

export function formatDate(date: string) {
  return `${date.slice(dateStart, dateEnd)} ${date.slice(timeStart, timeEnd)}`;
}
