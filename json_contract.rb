# JSON CONTRACT


# login

POST 'api/v1/sessions'
params: { "first": "name", "last": "name" }

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "first_name": "Beep",
      "last_name": "Beeperson",
      "lat": "45.84858",
      "long": "69.37472",
      "trucks": [
        {
          "id": "23",
          "lat": "53.23657",
          "long": "24.36676",
          "name": "truck_1",
          "distance": "2.4",
          "logo_small": "logo"
        },
        {
          "id": "2",
          "lat": "67.23657",
          "long": "28.36676",
          "name": "truck_2",
          "distance": "1.2",
          "logo_small": "logo"
        }
      ]
    }
  }
}

# new user registration

POST 'api/v1/users'
params { "first": "Beep", "last": "Beeperson", "street": "22 Hillcrest Dr", "city": "lander", "zip": "82520" }

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "first_name": "Beep",
      "last_name": "Beeperson",
      "lat": "45.84858",
      "long": "69.37472",
      "trucks": [
        {
          "id": "23",
          "lat": "53.23657",
          "long": "24.36676",
          "name": "truck_1",
          "distance": "2.4",
          "logo_small": "logo"
        },
        {
          "id": "2",
          "lat": "67.23657",
          "long": "28.36676",
          "name": "truck_2",
          "distance": "1.2",
          "logo_small": "logo"
        }
      ]
    }
  }
}

# truck show view

GET 'api/v1/trucks'
params: { "id": 2 }

{
  "data": {
    "type": "trucks",
    "id": "2",
    "attributes": {
      "name": "dope foods",
      "payment_methods": [],
      "website": "www.dope-af.com",
      # hashes for each site with logo(s)?
      "socials": [],
      "description": "text",
      "logo": "logo",
      "display": "street, etc."
    }
  }
}
