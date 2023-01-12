export function formatDate(date: string) {
  const splitDate: string[] = date.split("T");
  const dateFormatted: string = splitDate[0];
  const splitTime: string[] = splitDate[1].split(":");
  const timeFormatted: string = `${splitTime[0]}:${splitTime[1]}`;
  return `${dateFormatted} ${timeFormatted}`;
}
