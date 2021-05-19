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
      "long": "69.37472"
    }
  }
}

# new user registration

POST 'api/v1/users'
params: { "username": "some_beep", "first_name": "Beep", "last_name": "Beeperson", "street": "22 Hillcrest Dr", "city": "lander", "zip": "82520" }

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "first_name": "Beep",
      "last_name": "Beeperson",
      "lat": "45.84858",
      "long": "69.37472",
    }
  }
}

# truck show view

GET 'api/v1/trucks'

{
  "data": {
    "type": "trucks",
    "id": null,
    "attributes": {
      "trucks": [
        {
          "description": "text about truck",
          "description_short": "a brief description",
          "display": "Howe St & W Cordova St",
          "distance": "6.3",
          "logo": "some_logo.png",
          "name": "dope fooodz",
          "payment_methods": ["cash", "apple_pay", "credit_card"],
          "phone": "6103592275",
          "socials": [{"facebook": "handle"},{"twitter": "foodzzz"}],
          "website": "dope_provisions.eat",
          "lat": "32.23657",
          "long": "17.36676"
        },
        {
          "description": "text about truck",
          "description_short": "a brief description",
          "display": "Wynkoop St & Wazee St",
          "distance": "2.4",
          "logo": "some_other_logo.png",
          "name": "secret kebabs",
          "payment_methods": ["cash", "apple_pay", "debit_card"],
          "phone": "6102202222",
          "socials": [{"twitter": "meatz3"}],
          "website": "secret-meats.org/eat",
          "lat": "46.23657",
          "long": "20.36676"
        }
      ]
    }
  }
}
