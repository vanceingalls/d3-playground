d3.json 'data.json', (data) ->
  # assuming data all in the same month
  # and starts on the first
  new TripCalendar data, d3.select('.block .table')

class TripCalendar
  constructor: (@data, @container=d3.select('body')) ->
    bbox = @container.node().getBoundingClientRect()
    @boxDimension = bbox.width / 7
    @circleR = @boxDimension / 2
    @buildTable()
    @populateTable()

  buildTable: ->
    table = @container.insert('table')
    tbody = table.append('tbody')

    @buildRow tbody for i in [1..5]

  buildRow: (container) ->
    tr = container.append('tr')
    tr.append 'td' for i in [1..7]

  populateTable: ->
    self = @

    td = d3.selectAll 'td'
    .filter (d, i) -> i > 0
    .data @data
    .attr 'class', (d) ->
      return 'safe' if d.miles_driven < 40
      return 'danger' if d.miles_driven > 70
      return 'warning'
    .text (d) -> d.date.split('/')[1]

    .on 'mouseenter', ->
      td = d3.select @
      td.select 'svg text'
        .classed 'hidden', false
    .on 'mouseleave', ->
      td = d3.select @
      td.select 'text'
        .classed 'hidden', true
    .on 'click', (d) ->
      d3.select '.block .info'
      .html ->
        html = "Trips for <strong>#{d.date}</strong>: <br><ul>"
        html += "<li>time: #{segment.time} :: miles: #{segment.miles_driven}</li>" for segment in d.trips
        html += "</ul>"
        return html

    svg = td.append 'svg'

    svg.append 'circle'
      .attr 'r', (d) -> self.circleR * d.miles_driven / 100
      .attr('cx', self.circleR)
      .attr('cy', self.circleR)

    svg.append 'text'
      .attr 'dx', -6
      .attr 'dy', self.circleR + 6
      .html (d) -> d.miles_driven + ' miles'
      .classed 'hidden', true



