.pragma library

// Pure layout maths for one overview pane (no Quickshell types, so it is testable).
//
// Pills are 45° parallelograms of constant height. Along the pane's TOP edge they
// tile left-to-right inside [spanLeft, spanLeft + spanWidth]; every pill's bottom
// edge is shifted left by the pill height, so the top-edge span is all we budget.
//
//   list : [{ key, ref, focused }]           windows on this workspace
//   o    : { spanLeft, spanWidth, gap, minWidth, chipWidth }
//   ->   : { items: [{ key, ref, focused, x, w }], hidden, chipX, chipW, count }
//
// Rules:
//   * every pill is at least `minWidth` wide, so its icon stays readable
//   * if all windows don't fit, show as many as fit next to a "+N" chip and
//     make sure the focused window is always among the shown ones
//   * the focused pill gets extra width (room for a preview) while the others
//     can still stay >= minWidth
function plan(list, o) {
    const n = list.length;
    const res = { items: [], hidden: 0, chipX: 0, chipW: o.chipWidth, count: n };
    if (n === 0)
        return res;

    const W = o.spanWidth, g = o.gap, minW = o.minWidth;

    let shown = list;
    let area = W;
    const fitAll = Math.max(1, Math.floor((W + g) / (minW + g)));
    if (n > fitAll) {
        area = W - o.chipWidth - g;
        const cap = Math.max(1, Math.floor((area + g) / (minW + g)));
        shown = list.slice(0, cap);
        let fi = -1;
        for (let i = 0; i < n; i++) {
            if (list[i].focused) { fi = i; break; }
        }
        if (fi >= cap)
            shown[cap - 1] = list[fi];
        res.hidden = n - cap;
        res.chipX = o.spanLeft + area + g;
    }

    const m = shown.length;
    let hasFocus = false;
    for (let i = 0; i < m; i++)
        if (shown[i].focused) hasFocus = true;

    // widest focus weight that still leaves every other pill >= minWidth
    let f = 1;
    if (m > 1 && hasFocus) {
        const weights = [2.4, 1.8, 1.4];
        for (let k = 0; k < weights.length; k++) {
            const wo = (area - (m - 1) * g) / (m - 1 + weights[k]);
            if (wo >= minW) { f = weights[k]; break; }
        }
    }
    const unit = (m === 1) ? area : (area - (m - 1) * g) / (m - 1 + (hasFocus ? f : 1));

    let x = o.spanLeft;
    for (let i = 0; i < m; i++) {
        const w = (m === 1) ? area : (shown[i].focused ? unit * f : unit);
        res.items.push({ key: shown[i].key, ref: shown[i].ref, focused: shown[i].focused, x: x, w: w });
        x += w + g;
    }
    return res;
}
