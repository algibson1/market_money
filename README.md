# Market Money
[This project is part of Turing School of Software and Design's Mod3 Curriculum.](https://backend.turing.edu/module3/projects/market_money/index)
Learning goals for this project include:
- Expose an API
- Use serializers to format JSON responses
- Test API exposure
- Error handling
- Consume an API

In addition to achieving the required endpoints of the original project, this repo includes additional functionality from the [Advanced Active Record Workshop](https://gist.github.com/megstang/4d6b823200f0ce43155c84c5046f2a32) challenge.

## Project Description
This project creates a microservice that provides data to a fictional front-end application that allows users to search for information about farmer's markets and vendors at those markets. All endpoints return a JSON with requested information, formatted per [JSON:API specifications](https://jsonapi.org/).

## Endpoints
Base url: `http://localhost:3000/`

### RESTful Endpoints
`GET /api/v0/markets`

Returns list of all markets in the database.
```
   {
       "data": [
           {
               "id": "322458",
               "type": "market",
               "attributes": {
                   "name": "14&U Farmers' Market",
                   "street": "1400 U Street NW ",
                   "city": "Washington",
                   "county": "District of Columbia",
                   "state": "District of Columbia",
                   "zip": "20009",
                   "lat": "38.9169984",
                   "lon": "-77.0320505",
                   "vendor_count": 1
               }
           },
           {
               "id": "322474",
               "type": "market",
               "attributes": {
                   "name": "2nd Street Farmers' Market",
                   "street": "194 second street",
                   "city": "Amherst",
                   "county": "Amherst",
                   "state": "Virginia",
                   "zip": "24521",
                   "lat": "37.583311",
                   "lon": "-79.048573",
                   "vendor_count": 35
               }
           },
           ...,
           ...,
       ]
   }
```
---
`GET /api/v0/markets/:id`

Returns one market, by the market id.
```
   {
       "data": {
           "id": "322458",
           "type": "market",
           "attributes": {
               "name": "14&U Farmers' Market",
               "street": "1400 U Street NW ",
               "city": "Washington",
               "county": "District of Columbia",
               "state": "District of Columbia",
               "zip": "20009",
               "lat": "38.9169984",
               "lon": "-77.0320505",
               "vendor_count": 1
           }
       }
   }
```
---
`GET /api/v0/markets/:id/vendors`

Returns list of all vendors that sell at the market with the given market id.
```
{
    "data": [
        {
            "id": "55297",
            "type": "vendor",
            "attributes": {
                "name": "Orange County Olive Oil",
                "description": "Handcrafted olive oil made from locally grown olives",
                "contact_name": "Syble Hamill",
                "contact_phone": "1-276-593-3530",
                "credit_accepted": false,
                "states_sold_in": [
                    "Virginia"
                ]
            }
        },
        {
            "id": "56227",
            "type": "vendor",
            "attributes": {
                "name": "The Vodka Vault",
                "description": "Handcrafted vodka with a focus on unique and unusual flavors",
                "contact_name": "Rueben Parker DVM",
                "contact_phone": "1-140-885-8633",
                "credit_accepted": true,
                "states_sold_in": [
                    "Virginia"
                ]
            }
        },
         ...,
         ...,
     ]
 }
```
---
`GET /api/v0/vendors` 

Returns all vendors, in order by how many markets that vendor sells at.
This endpoint accepts the optional parameter of `state` and will return only the vendors that sell in the given state (ex `/api/v0/vendors?state=California`)
```
{
    "data": [
        {
            "id": "55557",
            "type": "vendor",
            "attributes": {
                "name": "The Upcycled Home",
                "description": "Upcycled furniture and decor",
                "contact_name": "Evan Mayert",
                "contact_phone": "1-880-165-0400",
                "credit_accepted": false,
                "states_sold_in": [
                    "California"
                ]
            }
        },
        {
            "id": "55752",
            "type": "vendor",
            "attributes": {
                "name": "Ginger Spice",
                "description": "Handmade soaps and lotions made with a ginger scent.",
                "contact_name": "Luke Hilll",
                "contact_phone": "454.619.7595",
                "credit_accepted": false,
                "states_sold_in": [
                    "California"
                ]
            }
        },
    ...
    ...
    ]
}
```

---
`GET /api/v0/vendors/:id` 

Returns one vendor by vendor id.
```
{
    "data": {
        "id": "54876",
        "type": "vendor",
        "attributes": {
            "name": "The Sourdough Queen",
            "description": "This vendor bakes a variety of artisanal breads using sourdough starter, from crusty baguettes to hearty whole wheat loaves.",
            "contact_name": "Kasi Greenholt",
            "contact_phone": "(172) 129-4294",
            "credit_accepted": true,
            "states_sold_in": [
                "California",
                "Nevada"
            ]
        }
    }
}
```
---
`POST /api/v0/vendors`

Attributes for a new vendor must be sent in the request body as JSON. Example:
```
 {
     "name": "Buzzy Bees",
     "description": "local honey and wax products",
     "contact_name": "Berly Couwer",
     "contact_phone": "8389928383",
     "credit_accepted": false
 }
```
A successful request requires all above attributes to be included, and will return the newly created vendor resource. A request that is missing attributes will return an appropriate error message.
```
{
    "data": {
        "id": "56591",
        "type": "vendor",
        "attributes": {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "contact_name": "Berly Couwer",
            "contact_phone": "8389928383",
            "credit_accepted": false,
            "states_sold_in": []
        }
    }
}
```

---
`PATCH /api/v0/vendors/:id`

Alternative attributes for an existing vendor must be sent in the request body as JSON, such as below.
```
 {
     "contact_name": "Kimberly Couwer",
     "credit_accepted": false
 }
```
A successful request will return the updated vendor resource.
```
{
    "data": {
        "id": "56592",
        "type": "vendor",
        "attributes": {
            "name": "Buzzy Bees",
            "description": "local honey and wax products",
            "contact_name": "Kimberly Couwer",
            "contact_phone": "8389928384",
            "credit_accepted": false,
            "states_sold_in": []
        }
    }
}
```
---
`DELETE /api/v0/vendors/:id`

Deletes the vendor resource by vendor id.

---
`POST /api/v0/market_vendors`

When a valid market id and vendor id are passed through the body like so:
```
 {
     "market_id": 322474,
     "vendor_id": 54861
 }
```
It will add that vendor to that market's list of vendors. The response is a message stating the vendor has been successfully added.
```
   {
     "message": "Successfully added vendor to market"
   }
```
---
`DELETE /api/v0/market_vendors`

When a valid market id and vendor id is passed through the body as shown below, and an association between that market and vendor exists, it will remove that vendor from that market's vendor list.
```
 {
     "market_id": 322474,
     "vendor_id": 54861
 }
```

### Non-RESTful Endpoints
`GET /api/v0/markets/search`

Allows a user to pass parameters of state, city, and/or market name to search for markets that might match those parameters.
City is not a valid parameter unless state is also included, but all other combinations of parameters are valid.
If valid search parameters are passed, the response will return any and all matching markets found. Format is similar to the `GET /api/v0/markets` endpoint.

---

`GET /api/v0/markets/:id/nearest_atms`

This endpoint consumes the TomTom API to return a list of cash dispensers close to the given market, ordered by distance from that market.
```
{
     "data": [
         {
             "id": null,
             "type": "atm",
             "attributes": {
                 "name": "ATM",
                 "address": "3902 Central Avenue Southeast, Albuquerque, NM 87108",
                 "lat": 35.07904,
                 "lon": -106.60068,
                 "distance": 0.10521432030421865
             }
         },
         {
             "id": null,
             "type": "atm",
             "attributes": {
                 "name": "ATM",
                 "address": "4100 Central Avenue Southeast, Albuquerque, NM 87108",
                 "lat": 35.0788,
                 "lon": -106.59842,
                 "distance": 0.14448001321588486
             }
         },
         ...,
         ...,
         ...,
     ]
 }
```
---
`GET /api/v0/vendors/multiple_states`

Returns a list of vendors that sell at markets in more than one state. Vendors are returned in order by how many states they sell in.

---
`GET /api/v0/vendors/popular_states`

Returns a list of states, with a number of vendors that sell in that state, in order by the total number of vendors.
This endpoint accepts an optional param of `limit` to return a certain number of states (ex: `api/v0/vendors/popular_states?limit=5`)
```
{
 "data": [
          {
              "state": "California", 
              "number_of_vendors": 152
          },
          {
              "state": "New York", 
              "number_of_vendors": 134
          },
          {
              "state": "Massachusetts", 
              "number_of_vendors": 70 
          },
          {
              "state": "Michigan", 
              "number_of_vendors": 68
          },
  ...
  ...
```

## Running On
Ruby 3.2.2
Rails 7.0.7.2

## Make a Local Copy
1. Fork this repo
2. Clone this repo
3. Install gems
```
bundle install
```
4. Create the database
```
rails db:{create,migrate,seed}
```
5. Set up Rails credentials
You will need to get a [TomTom API](https://developer.tomtom.com/) key.
When you have a key, run `EDITOR="code --wait" bin/rails credentials:edit` in the command line to open the credentials file. You may need to delete the existing `credentials.yml.enc` file.
In the opened credentials file, input your key in the following format:
```yml
tomtom:
  key: <YOUR-API-KEY>
```
You may now use the api key in the repo as `Rails.application.credentials.tomtom[:key]`

---
Interact with the database by launching a local host server and using [Postman](https://www.postman.com/downloads/) to send requests to any of the endpoints described above.
