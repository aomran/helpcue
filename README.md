# [HelpCue](http://www.helpcue.com)

[![Build Status](https://semaphoreci.com/api/v1/projects/4e05b0dd-c58e-4fde-ada7-be14092048f7/215316/shields_badge.svg)](https://semaphoreci.com/this_ahmed/helpcue) [![Code Climate](https://codeclimate.com/github/aomra015/helpcue/badges/gpa.svg)](https://codeclimate.com/github/aomra015/helpcue) [![Test Coverage](https://codeclimate.com/github/aomra015/helpcue/badges/coverage.svg)](https://codeclimate.com/github/aomra015/helpcue)

## Getting Started

This app requires Ruby 2.2.1 and Postgresql 9.3 in development and production.

1. `$ git clone git@github.com:aomra015/helpcue.git`
1. `$ cd helpcue`
1. `$ bin/setup`
1. `$ cp .env.example .env` -- Fill out the .env file with the appropriate environment variables.

### Start development environment (at localhost:5000)
- `$ foreman start`

### Run tests
- `$ rake` to run all Ruby tests.

### Official Browser Support
- Internet Explorer (Version 9+), Google Chrome (Latest Version), Mozilla Firefox (Latest Version), Apple Safari (Version 5+).
- Clients without Javascript are not supported.
- HelpCue supports mobile browsers.
