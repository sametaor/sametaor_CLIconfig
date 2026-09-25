.pragma library

// Pure date maths for the MONTH grid (no Quickshell/QML types, so it's testable).
// weekStart: 0 = Sunday first (as in the concept: S M T W T F S), 1 = Monday first.
//
// Returns 6 weeks x 7 days, always - a fixed grid so the flyout never resizes as
// you page between months. Days outside the shown month are marked !inMonth.
function weeksFor(year, month, weekStart) {
    weekStart = weekStart || 0;
    const first = new Date(year, month, 1);
    const startOffset = (first.getDay() - weekStart + 7) % 7;
    const gridStart = new Date(year, month, 1 - startOffset);

    const weeks = [];
    let cursor = new Date(gridStart);
    for (let w = 0; w < 6; w++) {
        const days = [];
        for (let d = 0; d < 7; d++) {
            days.push({
                day: cursor.getDate(),
                month: cursor.getMonth(),
                year: cursor.getFullYear(),
                inMonth: cursor.getMonth() === month,
                weekday: cursor.getDay()
            });
            cursor.setDate(cursor.getDate() + 1);
        }
        weeks.push(days);
    }
    return weeks;
}

function sameDate(a, y, m, d) {
    return a.year === y && a.month === m && a.day === d;
}

function weekdayLabels(weekStart) {
    const all = ["S", "M", "T", "W", "T", "F", "S"];
    weekStart = weekStart || 0;
    return all.slice(weekStart).concat(all.slice(0, weekStart));
}
