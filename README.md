# README


A credit card API written in rails 5.0.2, Ruby 2.3.0.

#### Getting going

1. Create a superuser account in the Rails console:
`2.3.0 :001 > User.create(email: "you@gmail.com", password: "foobars", superuser: true)`

2. Setup:
  - `bundle install`
  - `rake db:migrate`
  - `rails s`

2. For other requests, you can use curl, the Postman plugin for Chrome, or any
other request tool (I used postman).

3. All requests requiring authentication will require the following, base64 encoded,
and placed as the value of an `Authorization` key in your requests:
`YOUR_EMAIL:YOUR_PASSWORD`
This can easily be done in the Rails console, or here:
https://www.base64encode.org/

4. Create (other) users:
```
{
  "data":{
    "type": "users",
	"attributes": {
	  "email": "jbiden@whitehouse.gov",
	  "password": "foobars",
	  "address": "123 Hickory Lane",
	  "phone": "5555555555"
    }
  }
}
```
5. Create accounts for your users (you must be using superuser credentials
to do this):
```
{"data":
  {
    "type": "accounts",
    "attributes":
      {
        "apr": 0.25, "credit-limit": 10000
      }

   },
   "relationships": {
     "user": {
       "data": {"id": ID_OF_USER_FOR_ACCOUNT, "type":"users"}
     }
   }
}
```

6. Creating transactions - a transaction can be a charge or an account payment.
You will need to have the `Authorization` credentials related to the account owner
in your headers:
```
{"data":
  {
    "type": "transactions",
    "attributes":
      {
        "amount": 25, "currency": "USD", "for": "booze"
      }

   },
   "relationships": {
     "account": {
       "data": {"id": ID_OF_ACCOUNT_TO_CHARGE, "type":"accounts"}
     }
   }
}
```
7. View all transactions (for authorized user):

`http://localhost:3000/transactions`

8. Get individual account information (authorized user or superuser allowed):
`http://localhost:3000/accounts/ACCOUNT_ID`

9. As long as this app is running, everyday at 7:40 pm pacific time, a delayed
job will run. The job can be found here: `shylock/app/jobs/generate_statements.rb`

It will create statements, and charge monthly interest for due accounts.
