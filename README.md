# Nomadic Nibbler - Back End API

## About this Project
This application exposes an API for serving foodtruck information and geolocation radius information to an associated front end application.

## Authors
- **Kyle Schulz**
|    [GitHub](https://github.com/kylejschulz) |
[LinkedIn](https://www.linkedin.com/in/kyle-schulz-204056209/)

- **Tommy Nieuwenhuis**
|    [GitHub](https://github.com/tsnieuwen) |
[LinkedIn](https://www.linkedin.com/in/thomasnieuwenhuis/)

- **Wil McCauley**
|    [GitHub](https://github.com/wil-mcc) |
[LinkedIn](https://www.linkedin.com/in/wil-mccauley/)

## Acknowledgements

- [Google Distance API](https://developers.google.com/maps/documentation/distance-matrix/overview)
- [MapQuest Geocode API](https://developer.mapquest.com/documentation/geocoding-api/)
- [Street Food App API](https://streetfoodapp.com/api)

## Table of Contents

- [Getting Started](#getting-started)
- [Running the tests](#running-the-tests)
- [Built With](#built-with)
- [Authors](#authors)

### Prerequisites

To run this application you will need Ruby 2.5.3 and Rails 5.2.5

## Getting Started

To get the web application running:

1. Clone this repo
```
git@github.com:NomadicNibbler/foodtruck_be.git
```

2. Install gem packages: `bundle install`

3. Create and Migrate DB
```
$rails db:{create,migrate}
```
4. Install needed Figaro config
```
$bundle exec figaro install
```
5. Add environment variables to `config/application.yml`

```
COORD_URL: 'http://www.mapquestapi.com'
COORD_KEY: 'your_mapquest_api_key'

GOOGLE_MAPS_API_KEY: 'your_google_api_key'
```

6. Start your server!
```
$ rails s
```

## Running the tests

```
bundle exec rspec
```

## Acknowledgments

  - Hat tip to anyone whose code is used
  - Inspiration
  - etc
