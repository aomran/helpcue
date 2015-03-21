![image](https://codeship.com/projects/69278/status?branch=master)
# [HelpCue](http://www.helpcue.com)

## Getting Started

The development environment requires the Ruby 2.2.1 and Postgresql. To get this setup please follow the instructions in the [Wiki](https://github.com/aomra015/helpcue/wiki) but make sure you upgrade everything.

1. `$ git clone git@github.com:aomra015/helpcue.git`
1. `$ cd helpcue`
1. `$ bundle install`
1. `$ rake db:create` ONLY THE FIRST TIME
1. `$ rake db:migrate`
1. `$ cp .env.example .env` -- Fill out the .env file with the appropriate environment variables.

### Start development environment (at localhost:3000)
- `$ foreman start`

### Run tests
- `$ rake` to run all Ruby tests.
