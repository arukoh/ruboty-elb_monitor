# Ruboty::ElbMonitor

[Ruboty](https://github.com/r7kamura/ruboty) plug-in to monitor AWS ELB.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-elb_monitor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-elb_monitor

## ENV
```
ELB_REGION            - AWS region for ELB (default: ENV["AWS_REGION"])
ELB_ACCESS_KEY_ID     - AWS access key for ELB (default: ENV["AWS_ACCESS_KEY_ID"])
ELB_SECRET_ACCESS_KEY - AWS secret key for ELB (default: ENV["AWS_SECRET_ACCESS_KEY"])
ELB_METRICS           - Metric list to monitor (default: "RequestCount,HealthyHostCount,UnHealthyHostCount,HTTPCode_ELB_4XX,HTTPCode_ELB_5XX,HTTPCode_Backend_2XX,HTTPCode_Backend_4XX,HTTPCode_Backend_5XX,BackendConnectionErrors,SurgeQueueLength,SpilloverCount,Latency")
ELB_TREND_SEPARATOR   - Trend separator (default: ' ')
```

## Usage
```
$ bundle exec ruboty
Type `exit` or `quit` to end the session.
> @ruboty help elb
ruboty /add elb (?<name>.+) (?<real_name>.+)/ - Add a new alias name of elb to monitor.
ruboty /delete elb (?<name>.+)/ - Delete a alias name of elb to monitor.
ruboty /list elb names\z/ - List all elb names.
ruboty /show elb state (?<from>(?:(?!last).)+) (?<to>.+)/ - Show all elb status of the specified period.
ruboty /show elb state last (?<time>\d+)(?<format>(w|d|h|m))\z/ - Show all elb status of the last [w]eeks, [d]ays, [h]ours or [m]inutes.
ruboty /show elb state last (?<time>\d+)(?<format>(w|d|h|m)) trend\z/ - Show all elb status with trend of the last [w]eeks, [d]ays, [h]ours or [m]inutes.
```

### Example
```
$ bundle exec ruboty
Type `exit` or `quit` to end the session.
> @ruboty add elb foo elb-name-xxx
ELB foo registerd.
> @ruboty list elb names
foo: elb-name-xxx
> @ruboty show elb state 20160320 20160323
2016-03-20T00:00:00Z - 2016-03-23T00:00:00Z
*** foo(elb-name-xxx) ***
  - RequestCount(Sum)           	37
  - HealthyHostCount(Average)   	1
  - UnHealthyHostCount(Average) 	0
  - HTTPCode_ELB_4XX(Sum)       	0
  - HTTPCode_ELB_5XX(Sum)       	1
  - HTTPCode_Backend_2XX(Sum)   	23
  - HTTPCode_Backend_4XX(Sum)   	12
  - HTTPCode_Backend_5XX(Sum)   	1
  - BackendConnectionErrors(Sum)	0
  - SurgeQueueLength(Maximum)   	0
  - SpilloverCount(Sum)         	0
  - Latency(Maximum)            	61.41
> @ruboty show elb state last 3d
2016-03-20T00:00:00Z - 2016-03-23T00:00:00Z
*** foo(elb-name-xxx) ***
  - RequestCount(Sum)           	37
  - HealthyHostCount(Average)   	1
  - UnHealthyHostCount(Average) 	0
  - HTTPCode_ELB_4XX(Sum)       	0
  - HTTPCode_ELB_5XX(Sum)       	1
  - HTTPCode_Backend_2XX(Sum)   	23
  - HTTPCode_Backend_4XX(Sum)   	12
  - HTTPCode_Backend_5XX(Sum)   	1
  - BackendConnectionErrors(Sum)	0
  - SurgeQueueLength(Maximum)   	0
  - SpilloverCount(Sum)         	0
  - Latency(Maximum)            	61.41
> @ruboty show elb state last 3d trend
2016-03-20T00:00:00Z - 2016-03-23T00:00:00Z
*** foo(elb-name-xxx) ***
  - RequestCount(Sum)           	0 0 37
  - HealthyHostCount(Average)   	1 1 1
  - UnHealthyHostCount(Average) 	0 0 0
  - HTTPCode_ELB_4XX(Sum)       	0 0 0
  - HTTPCode_ELB_5XX(Sum)       	0 0 1
  - HTTPCode_Backend_2XX(Sum)   	0 0 23
  - HTTPCode_Backend_4XX(Sum)   	0 0 12
  - HTTPCode_Backend_5XX(Sum)   	0 0 1
  - BackendConnectionErrors(Sum)	0 0 0
  - SurgeQueueLength(Maximum)   	0 0 0
  - SpilloverCount(Sum)         	0 0 0
  - Latency(Maximum)            	0 0 61.41
> @ruboty delete elb foo
ELB foo deleted
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruboty-elb_monitor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

