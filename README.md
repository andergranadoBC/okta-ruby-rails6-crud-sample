# Ruby on Rails Okta Authentication PoC

The project used as Proof of Concept of Authentication through Okta in a Ruby on Rails App is [okta-ruby-rails6-crud-sample](https://github.com/oktadev/okta-ruby-rails6-crud-sample).
    
- The project uses `devise` for identity and authentication management and `omniauth` with Okta Strategy to authenticate with Okta via OAuth2 
- [More info](https://developer.okta.com/blog/2020/09/25/easy-auth-ruby-on-rails-6-login) about the base project 
    
## Requirements

- Rails 6+
- Ruby 2.5.0 or higher (project is set for 2.5.0)
    - Using [rvm](https://rvm.io/) or similar Ruby management tool is recommended

## Configuration steps

Clone the application in your local machine:

```
git clone https://github.com/andergranadoBC/okta-ruby-rails6-crud-sample.git
```

### In Okta

Create a new OICD application in Admin Console with grant type as "Authorization Code" and save the generated client ID and secret. Ensure that all the log in/out redirects are correcly setted both in app settings and in trusted origins.

### In the app

Some variables need to be setted in `config/initializers/devise.rb` or through environmental variables:

- `OKTA_URL`: Okta Org's URL
- `OKTA_CLIENT_ID`: The generated client ID
- `OKTA_CLIENT_SECRET`: The generated client secret
    -  **This should never be published**
- `OKTA_ISSUER`: The URL of the Authorization Server used to mint tokens
- `OKTA_AUTH_SERVER_ID`: The id of the Authorization Sever used (`default` for the default one)
- `OKTA_REDIRECT_URI`: The configured redirect URI (`http://localhost:3000/users/auth/oktaoauth/callback` or for this app)

Those variables depends on the okta tenant used and its configuration.

Configurations for [`omniauth-oktaoauth`](https://github.com/andrewvanbeek-okta/omniauth-oktaoauth) and [`omniauth-okta`](https://github.com/omniauth/omniauth-okta) are both included. The project is configured to use the first one, that coluld be changed depending on the capabilities required.

## Running the project

If using enviromental variables, export them with `export` or similar. At least, the `OKTA_URL` variable needs to be exported before running the app even when hardcoding omniauth configuration.

After configuring the project, to install the gems, set the DB and run the project, run the following:

```bash
bundle install
rake db:create
rails s
```

Open http://localhost:3000 to access the application.

## Changes

The PoC extends the original project changing the following:

- Adds [omniauth-okta](https://github.com/omniauth/omniauth-okta) support along with existing [omniauth-oktaoauth](https://github.com/andrewvanbeek-okta/omniauth-oktaoauth) gem, being able to change between those when required.
- Adds some pages as PoC for specific behaviors for different user types.
    - Uses custom claims gathered from the authentication info (i.e. OIDC Access/ID tokens) to see what type of user is authenticated and set a session with that specific info.

## License

Apache 2.0, see [LICENSE](LICENSE).
