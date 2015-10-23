var TripCalendar;

d3.json('/data.json', function(data) {
  var tripCalendar;
  return tripCalendar = new TripCalendar(data.data, d3.select('.block'));
});

TripCalendar = (function() {
  function TripCalendar(data1, container1) {
    this.data = data1;
    this.container = container1 != null ? container1 : d3.select('body');
    this.buildTable();
  }

  TripCalendar.prototype.buildCell = function(row) {
    var circle, status, svg, td;
    td = row.append('td');
    status = ['success', 'warning', 'danger', 'info'];
    td.classed(status[Math.floor(Math.random() * 4)], true);
    svg = td.append('svg');
    circle = svg.append('circle');
    circle.attr('cx', '50%');
    circle.attr('cy', '50%');
    return circle.attr('r', 10);
  };

  TripCalendar.prototype.buildRow = function(container) {
    var i, j, results, tr;
    tr = container.append('tr');
    results = [];
    for (i = j = 1; j <= 7; i = ++j) {
      results.push(this.buildCell(tr));
    }
    return results;
  };

  TripCalendar.prototype.buildTable = function() {
    var i, j, results, table, tbody;
    table = this.container.append('table');
    table.classed('table', true);
    tbody = table.append('tbody');
    results = [];
    for (i = j = 1; j <= 5; i = ++j) {
      results.push(this.buildRow(tbody));
    }
    return results;
  };

  return TripCalendar;

})();


/*
circle = d3.selectAll 'circle'
circle.attr("r", 30)
 */

//# sourceMappingURL=script.js.map
