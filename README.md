# Scissor API - Documentation

## API Overview

Scissor is a simple tool which makes URLs as short as possible. : Its implemented in both REST and GraphQL. Both APIs allow users to create a short link for a url as well as resolve it. The APIs also allow users to perform account-related operations such as creating a new account, logging in with existing credentials, and logging out of the current session.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

```
ruby
rails
psql
```

### Setting up locally

#### Step 1: Clone the repository

```
git clone https://github.com/benessilfie/scissor.git
```

or with Github CLI

```
gh repo clone benessilfie/scissor
```

#### Step 2: Install gems

```
bundle install
```

#### Step 3: Create and Migrate your database

```sh
rails db:create
```

```sh
rails db:migrate
```

#### Step 4: start the server

```
rails server
```

## Documentation

## REST API

The REST API follows a traditional RESTful architecture and uses HTTP verbs to interact with resources. It supports the following endpoints:

### User Endpoints

##### 1. Get User

- `GET /users/:id` - Get a specific user by ID

- `Headers` - `{Authorization: 'Bearer <token>'}`

**Response**

`200 - OK`

```json
{
  "data": {
    "id": "integer",
    "type": "string",
    "attributes": {
      "email": "string",
      "username": "string",
      "created_at": "dateTime",
      "updated_at": "dateTime"
    },
    "relationships": {
      "urls": {
        "data": []
      }
    }
  },
  "included": []
}
```

##### 2. Create User

- `POST /users` - Create a new user account

**Request Body**

```json
{
  "email": "string",
  "username": "string",
  "password": "string",
  "passowrd_confirmation": "string"
}
```

**Response**

`201 - Created`

```json
{
  "data": {
    "id": "integer",
    "type": "string",
    "attributes": {
      "email": "string",
      "username": "string",
      "created_at": "dateTime",
      "updated_at": "dateTime"
    },
    "relationships": {
      "urls": {
        "data": []
      }
    }
  }
}
```

##### 3. Update User

- `PUT /users/:id` - Update a specific user by ID

- `Headers` - `{Authorization: 'Bearer <token>'}`

**Request Body**

```json
{
  "email": "string",
  "username": "string"
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "id": "integer",
    "type": "string",
    "attributes": {
      "email": "string",
      "username": "string",
      "created_at": "dateTime",
      "updated_at": "dateTime"
    },
    "relationships": {
      "urls": {
        "data": []
      }
    }
  }
}
```

- `DELETE /users/:id` - Delete a specific user by ID

##### 4. Delete User

- `PUT /users/:id` - Update a specific user by ID

- `Headers` - `{Authorization: 'Bearer <token>'}`

**Response**

`204 - No Content`

### URL's Endpoints

##### 1. Shorten a URL

- `POST /shorten` - Create a shorten link

- `Headers` - `{Authorization: 'Bearer <token>'}` `OPTIONAL`

**Request Body**

```json
{
  "original_url": "string"
}
```

**Response**

`201 - Created`

```json
{
  "short_url": "string",
  "short_code": "string"
}
```

##### 2. Redirect to Original URL

- `GET /:short_code` - redirect to original url

- `Headers` - `{Authorization: 'Bearer <token>'}` `OPTIONAL`

**Response** (otherwise `404 Not Found`)

`200 - OK`

`Redirects to the original url`

## Analytics

##### 1. Get URL Stats

- `GET /:short_code/stats` - Check the number of times the short link has been visited

- `Headers` - `{Authorization: 'Bearer <token>'}` `OPTIONAL`

**Response**

`200 - OK`

```json
{
  "number_of_times_visted": 1
}
```

### Session

##### 1. Login

- `POST /login` - Log in with an existing user account

**Request Body**

```json
{
  "email": "string", // or "username": "string"
  "password": "string"
}
```

**Response**
`200 - OK`

```json
{
  "token": "JWT Token"
}
```

##### 2. Logout

- `DELETE /logout` - Log out of an existing user account

- `Headers` - `{Authorization: 'Bearer <token>'}`

**Response**
`204 - No Content`

## GraphQL API

The GraphQL API provides a more flexible and efficient way to query and mutate data. It supports the following types and operations:

### Types

- `UrlType` - represents a URL type
- `UserType` - represents a user type

### Operations

#### `Queries`

##### 1. Fetch User Profile

- `Profile` - fetches the profile of the current logged in user

**Request Body**

- `Headers` - `{Authorization: '<token>'}`

```json
query {
  profile {
    id
    email
    username
    createdAt
    updatedAt
  }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "profile": {
      "id": "integer",
      "email": "string",
      "username": "string",
      "createdAt": "dateTime",
      "updatedAt": "dateTime"
    }
  }
}
```

### `Mutations`

#### `User`

##### 1. Create User

- `createUser` - creates a new user account

**Request Body**

```json
mutation {
    createUser(input: {
        email: "string"
        username: "string"
        password: "string"
        passwordConfirmation: "string"
    }) {
        user {
            email
            username
        }
    }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "createUser": {
      "user": {
        "email": "string",
        "username": "string"
      }
    }
  }
}
```

##### 2. Update User

- `updateUser` - updates an existing user account

- `Headers` - `{Authorization: '<token>'}`

**Request Body**

```json
mutation {
    updateUser(input: {
        email: "string" // Optional
        username: "string" // Optional
    }) {
        user {
            email
            username
        }
    }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "createUser": {
      "user": {
        "email": "string",
        "username": "string"
      }
    }
  }
}
```

##### 3. Delete User

- `deleteUser` - deletes a specific logged in user (requires `user password`)

- `Headers` - `{Authorization: '<token>'}`

**Request Body**

```json
mutation {
    deleteUser(input: {
        password: "string"
    }) {
        success
    }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "deleteUser": {
      "sucess": "boolean"
    }
  }
}
```

##### 4. Login

- `login` - create a token for a new user session (requires `email password`)

**Request Body**

```json
mutation {
  login(input: {
    email:"string@string.com",
    password: "string"
  }) {
    token
  }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "login": {
      "token": "string"
    }
  }
}
```

##### 5. Logout

- `logout` - logs out of the current user session

- `Headers` - `{Authorization: '<token>'}`

**Request Body**

```json
mutation {
  logout(input: {}) {
    success
  }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "logout": {
      "success": "boolean"
    }
  }
}
```

#### `URL`

##### 1. Create Shortened Url

- `createUrl` - creates a shortened URL

- `Headers` - `{Authorization: '<token>'}` `OPTIONAL`

**Request Body**

```json
mutation {
    createUrl(input: {
        originalUrl: "www.ebay.com"
    }) {
        url {
            shortUrl
            shortCode
        }
    }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "createUrl": {
      "url": {
        "shortUrl": "string",
        "shortCode": "string"
      }
    }
  }
}
```

##### 2. Resolve Short URL

- `resolveShortUrl` - returns a redirect URL when provided the short code

**Request Body**

```json
mutation {
    resolveShortUrl(input: {
        shortCode: "string"
    }) {
        url {
            shortUrl
        }
    }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "resolveShortUrl": {
      "url": {
        "shortUrl": "string"
      }
    }
  }
}
```

## Analytics

##### 1. URL Stats

- `urlStats` - returns the `count` representing how many times a short URL has been visited

**Request Body**

```json
mutation {
    urlStats(input: {
        shortCode: "string"
    }){
        url {
            count
        }
    }
}
```

**Response**

`200 - OK`

```json
{
  "data": {
    "urlStats": {
      "url": {
        "count": "integer"
      }
    }
  }
}
```

## Data Schema

Both APIs use the same data schema to represent URL's and users. The schema is as follows:

URL Schema

```json
{
  "id": "string",
  "original_url": "string",
  "short_code": "string",
  "short_url": "boolean",
  "count": "integer",
  "user_id": "integer",
  "created_at": "DateTime",
  "updated_at": "DateTime"
}
```

### User Schema

```json
{
  "id": "string",
  "email": "string",
  "username": "string",
  "password_digest": "string",
  "auth_token": "string",
  "urls": ["url"],
  "created_at": "DateTime",
  "updated_at": "DateTime"
}
```

### Example

#### Creating a user account (REST API)

- curl

```sh
curl --location --request POST 'http://localhost:3000/users' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@hey.com",
    "username": "test",
    "password": "password",
    "password_confirmation": "password"
}'
```

- httpie

```sh
http -v :3000/users email=test@hey.com username=test password=password password_confirmation=password
```

- postman

```sh
{
    "email": "test@hey.com",
    "username": "test",
    "password": "password",
    "password_confirmation": "password"
}
```

#### Response

```sh
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "test@hey.com",
            "username": "test",
            "created_at": "2023-05-11T21:37:43.555Z",
            "updated_at": "2023-05-11T21:37:43.555Z"
        },
        "relationships": {
            "urls": {
                "data": []
            }
        }
    }
}
```

#### Creating a user account (GraphQL)

```json
mutation {
    createUser(input: {
        email: "test@hey.com"
        username: "test"
        password: "password"
        passwordConfirmation: "password"
    }) {
        user {
            email
            username
        }
    }
}
```

#### Response

```json
{
  "data": {
    "createUser": {
      "user": {
        "email": "test@hey.com",
        "username": "test"
      }
    }
  }
}
```

## Author

[Benjamin Essilfie Quansah](https://www.github.com/benessilfie/)
