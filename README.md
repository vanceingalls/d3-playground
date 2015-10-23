data generated with the following script:

```sh
[
  {
    'repeat:31': {
      date: '10/{{index()}}/2015',
      miles_driven: '{{integer(0,100)}}',
      trips: function (tags) {
        var leftover_miles = this.miles_driven;
        var trips = [];
        
        while (leftover_miles > 0) {          
          var min = Math.min(10, leftover_miles);
          var max = Math.min(25, leftover_miles);
          var tripMiles = tags.integer(min, max);
          
          leftover_miles = leftover_miles - tripMiles;
          
          trips.push({
            miles_driven: tripMiles
          });
        }
        
        var hour = 10;
        var segment = Math.floor(23/trips.length);
        for(var i = 0; i < trips.length; i++) {
          hour = hour + tags.integer(0, segment);
          var minute = tags.integer(0, 59);
          if (minute < 10) {
            minute = '0' + minute;
          }
          
          trips[i].time = hour + ':' + minute;
        }
        
        return trips;
      }
    }
  }
]
```