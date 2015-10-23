d3.json '/data.json', (data) ->
  # assuming data all in the same month
  # and starts on the first
  tripCalendar = new TripCalendar data.data, d3.select('.block')

class TripCalendar
  constructor: (@data, @container=d3.select('body')) ->
    @buildTable()

  buildCell: (row) ->
    td = row.append 'td'

    status = ['success', 'warning', 'danger', 'info']

    td.classed(status[Math.floor(Math.random()*4)], true)
    svg = td.append 'svg'
    circle = svg.append 'circle'
    circle.attr('cx', '50%')
    circle.attr('cy', '50%')
    circle.attr('r', 10)

  buildRow: (container) ->
    tr = container.append('tr')
    @buildCell tr for i in [1..7]

  buildTable: ->
    table = @container.append('table')
    table.classed('table', true)
    tbody = table.append('tbody')

    @buildRow tbody for i in [1..5]

    #td = tr.append('td')
    #td.classed('success', true)
    #td.html('hi')


###
circle = d3.selectAll 'circle'
circle.attr("r", 30)###
