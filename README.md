# Helpcue App

## Getting Started

The development environment requires the Ruby 2.1.1 and Postgresql. To get this setup please follow the instructions in the [Wiki](https://github.com/aomra015/helpcue/wiki) but make sure you upgrade everything.

1. `$ git clone git@github.com:aomra015/helpcue.git`
1. `$ cd helpcue`
1. `$ bundle install`
1. `$ rake db:create` ONLY THE FIRST TIME
1. `rake db:migrate`

### Start development environment (at localhost:3000)
- `$ rails s`

### Run tests
- `$ rake test` to run all Ruby tests.