# Kemet

Ruby implementation of Kemet board game


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kemet'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install kemet

## Usage

Run `bin/console`

```ruby
    match = Kemet::Match.new
    black_player = match.add_player(:black)
    green_player = match.add_player(:green)

    match.setup!

    match.waiting_player_action? #=> true

    match.next_action #=> Action(type: AddPyramid, player: :green, targets: [Area1, Area2, Area3])

    green_player.action(AddPyramid.new(:ruby, level: 1, target: Area1))

    match.current_action_fullfiled? #=> false

    green_player.action(AddPyramid.new(:diamond, level: 2, target: Area2))

    match.current_action_fullfiled? #=> true

    match.next_action #=> Action(type: AddPyramid, player: :black, targets: [Area6, Area7, Area8])

    black_player.action(AddPyramid.new(:diamond, level: 1, target: Area6))
    black_player.action(AddPyramid.new(:diamond, level: 1, target: Area7))
    black_player.action(AddPyramid.new(:diamond, level: 1, target: Area8))

    match.next_action #=> nil

    match.start! # ???

    match.next_action #=> Action(type: PlayerAction, player: :green, targets: [])

    green_player.action(Pray)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/detierno/kemet.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
