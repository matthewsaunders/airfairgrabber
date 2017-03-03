# AirFair Grabber

**AirFair Grabber** collects and processes flight data and packages it into a consumable JSON object.

## Sources
These are the flight data sources currently supported by **AirFair Grabber**.

- Google Flights
- ~~American Airlines~~ _(coming soon)_
- ~~Delta~~ _(coming soon)_

## Sample Output
This JSON object is an example of a trip object. A trip may have multiple flights and consists of at least one flight object.

```
{
    :flights => [
        [0] {
            :departure => {
                    :datetime => #<DateTime: 2017-03-18T17:50:00+00:00 ((2457831j,64200s,0n),+0s,2299161j)>,
                    :airport => "Boston (BOS)"
            },
            :arrival => {
                    :datetime => #<DateTime: 2017-03-18T19:19:00+00:00 ((2457831j,69540s,0n),+0s,2299161j)>,
                    :airport => "Newark (EWR)"
            },
            :flight_number => "United 4072",
                :seat_class => "Economy Class",
                :plane_model => "Embraer ERJ-135/145",
                :operator => "Operated by Expressjet Airlines DBA United Express"
        },
        [1] {
            :departure => {
                  :datetime => #<DateTime: 2017-03-18T20:25:00+00:00 ((2457831j,73500s,0n),+0s,2299161j)>,
                  :airport => "Newark (EWR)"
            },
            :arrival => {
                  :datetime => #<DateTime: 2017-03-18T23:25:00+00:00 ((2457831j,84300s,0n),+0s,2299161j)>,
                  :airport => "Miami (MIA)"
            },
            :flight_number => "United 1537",
            :seat_class => "Economy Class",
            :plane_model => "Boeing 737",
            :operator => nil
        }
    ],
        :cost => "144"
}
```

## Including in rails
Add the follow code segment to your `Gemfile`.

```
gem 'airfairgrabber', git: 'https://github.com/msaun008/airfairgrabber'
```

## Testing
To test the gem locally, use the `driver.rb` file in the root of this project.

```
$> ruby driver.rb
```
