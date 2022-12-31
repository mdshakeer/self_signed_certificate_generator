# self_signed_certificate_generator

Self Signed Certificate Generator is a Ruby library helps to create a self signed SSL certificate

## Getting started
You need to run ``bundle install`` to setup the application with all the required gems. Once it's done, it is ready to use. you can start running the application by running the command ``rails s``, this will start the application in the default port ``3000``

## Usage
### 1. API
If you are running the server in 3000 port, ``http://localhost:3000/api/v1/certificates/expire_date`` is the end point and ``cert`` is the query parameter to pass the generated certificate into it. This will check the date of certificate expiration.
### 2. Test connection
It's a rake task to run and check whether the API is responding or not, 

```ruby
rake self_signed_certificate:test_connection
```
The above task will return success or failure message.
> Note: If you are running the server in different port instead of 3000, you need to change port number in ``lib/tasks/self_signed_certificate.rake`` line number 11
### 3. Test the code
You can run the below command and ensure all the test cases are working fine.
```ruby
rake test
```