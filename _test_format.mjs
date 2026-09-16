function formatTime(time) {
  if (!time) return time;
  if (/^\d{1,2}:\d{2}$/.test(time)) return time;
  const d = new Date(time);
  if (isNaN(d.getTime())) return time;
  const h = String(d.getHours()).padStart(2,'0');
  const m = String(d.getMinutes()).padStart(2,'0');
  return h + ':' + m;
}
console.log('ISO   :', formatTime('1899-12-30T02:23:18.000Z'));
console.log('HH:mm :', formatTime('10:00'));
console.log('single:', formatTime('2:5'));
console.log('empty :', JSON.stringify(formatTime('')));
console.log('null  :', JSON.stringify(formatTime(undefined)));
console.log('junk  :', formatTime('abc'));
