var TripCalendar;

d3.json('data.json', function(data) {
  return new TripCalendar(data, d3.select('.block .table'));
});

TripCalendar = (function() {
  function TripCalendar(data1, container1) {
    var bbox;
    this.data = data1;
    this.container = container1 != null ? container1 : d3.select('body');
    bbox = this.container.node().getBoundingClientRect();
    this.boxDimension = bbox.width / 7;
    this.circleR = this.boxDimension / 2;
    this.buildTable();
    this.populateTable();
  }

  TripCalendar.prototype.buildTable = function() {
    var i, j, results, table, tbody;
    table = this.container.insert('table');
    tbody = table.append('tbody');
    results = [];
    for (i = j = 1; j <= 5; i = ++j) {
      results.push(this.buildRow(tbody));
    }
    return results;
  };

  TripCalendar.prototype.buildRow = function(container) {
    var i, j, results, tr;
    tr = container.append('tr');
    results = [];
    for (i = j = 1; j <= 7; i = ++j) {
      results.push(tr.append('td'));
    }
    return results;
  };

  TripCalendar.prototype.populateTable = function() {
    var self, svg, td;
    self = this;
    td = d3.selectAll('td').filter(function(d, i) {
      return i > 0;
    }).data(this.data).attr('class', function(d) {
      if (d.miles_driven < 40) {
        return 'safe';
      }
      if (d.miles_driven > 70) {
        return 'danger';
      }
      return 'warning';
    }).text(function(d) {
      return d.date.split('/')[1];
    }).on('mouseenter', function() {
      td = d3.select(this);
      return td.select('svg text').classed('hidden', false);
    }).on('mouseleave', function() {
      td = d3.select(this);
      return td.select('text').classed('hidden', true);
    }).on('click', function(d) {
      return d3.select('.block .info').html(function() {
        var html, j, len, ref, segment;
        html = "Trips for <strong>" + d.date + "</strong>: <br><ul>";
        ref = d.trips;
        for (j = 0, len = ref.length; j < len; j++) {
          segment = ref[j];
          html += "<li>time: " + segment.time + " :: miles: " + segment.miles_driven + "</li>";
        }
        html += "</ul>";
        return html;
      });
    });
    svg = td.append('svg');
    svg.append('circle').attr('r', function(d) {
      return self.circleR * d.miles_driven / 100;
    }).attr('cx', self.circleR).attr('cy', self.circleR);
    return svg.append('text').attr('dx', -6).attr('dy', self.circleR + 6).html(function(d) {
      return d.miles_driven + ' miles';
    }).classed('hidden', true);
  };

  return TripCalendar;

})();

//# sourceMappingURL=script.js.map
