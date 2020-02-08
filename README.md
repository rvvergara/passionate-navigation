# Passionate Navigation

### by: [Ryan V](https://github.com/rvvergara)

### Endpoints (using httpie):

1. Create user

```bash
POST /v1/users
```

**Parameters**

- user
  - type: json
  - nested parameters:
    - email -> string
    - password -> string
    - password_confirmation -> string

**Response Body**

```bash
{
    "data": {
        "email": "john@gmail.com",
        "id": "c2522a9c-4394-4e26-b255-445e8e5c5f22"
    },
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6ImMyNTIyYTljLTQzOTQtNGUyNi1iMjU1LTQ0NWU4ZTVjNWYyMiIsImVtYWlsIjoiam9obkBnbWFpbC5jb20iLCJleHAiOjE1ODEyNTMyMjB9.U6UhNDlhYNBS1kn7bizcULqK7_U80ch8ntQpE5PpyWA"
}
```

2. Authenticate user

```bash
POST :3000/v1/sessions
```

**Parameters**

- email -> string
- password -> string

**Response Body**

```bash
{
    "data": {
        "email": "john@gmail.com",
        "id": "c2522a9c-4394-4e26-b255-445e8e5c5f22"
    },
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6ImMyNTIyYTljLTQzOTQtNGUyNi1iMjU1LTQ0NWU4ZTVjNWYyMiIsImVtYWlsIjoiam9obkBnbWFpbC5jb20iLCJleHAiOjE1ODEyNTMyMjB9.U6UhNDlhYNBS1kn7bizcULqK7_U80ch8ntQpE5PpyWA"
}
```

**All requests from hereon require the ff in the header**

```bash
"Authorization: Bearer <token from authenticating user>"
```

3. Get list of verticals

```bash
GET /v1/verticals
```

**Response Body**

```bash
{
    "count": 3,
    "data": [
        {
            "id": "f264e2be-c3cd-4928-aea5-12295c2b505d",
            "name": "Health & Fitness"
        },
        {
            "id": "156cc1a1-e79f-4fb4-a1f4-1fe32c82e0f5",
            "name": "Business"
        },
        {
            "id": "befe1ffd-e11a-4534-a691-a1082ba3694c",
            "name": "Music"
        }
    ]
}
```

4. Create a vertical

```bash
POST /v1/verticals
```

**Parameters**

- vertical -> hash w/ the following nested parameters
  - name -> string

**Response Body**

```bash
{
    "id": "befe1ffd-e11a-4534-a691-a1082ba3694c",
    "name": "Music"
}
```
