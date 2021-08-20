# Search endpoint

A simple demo application that uses RapidAPI to query Google and Bing and allows the user to get standarized information from each one of them or both. The application accepts a query in the `/search` endpoint with the following parameters:

- search: the query
- engine: the search engine which can be `google`, `bing` or `both`

## Features
1. Validates the parameters
1. Caches the queries improving performance and avoiding needless requests
1. Fully stateless: it does not use the database at all
1. Record-less models: all information is structured in ActiveModel::Model classes
1. Implemented using the Service pattern
1. Bilingual (see the demo section)
1. Random but deterministic mixed results when using `both` engines

## Installing and running locally

### System dependencies

A Linux machine is preferred. Install the following dependencies (the process varies depending on your local setup):
| Dependency                | Version                |
| ------------------------- | ---------------------- |
| GIT VCS                   | **any modern version** |
| Ruby                      | 3.0.2+                 |
| Node.js                   | 16.4+                  |
| PostgreSQL                | 12+                    |
| Redis                     | 6+                     |
| Foreman                   | 0.87+                  |
| Google Chrome or Chromium | **any modern version** |
| Firefox                   | **any modern version** |

### Instructions

1. Clone this repository locally, for example `git clone https://github.com/NoTengoBattery/rails-search`
1. Change to the project's root directory, for example `cd rails-search`
1. Install the Ruby dependencies with `bundle install`
1. Install the Node.js dependencies with `yarn install`
1. Roll a new set of credentials with `rm config/credentials.yml.enc; bundle exec rails credentials:edit`
   - May need to set-up a proper text editor for this command to work. Try `export EDITOR=nano`
   - To deploy to staging and review applications, add HTTP login details in this file. Not needed locally.
   - Need to subscribe to the following APIs and add the RapidAPI key: [Google](https://rapidapi.com/apigeek/api/google-search3/) [Bing](https://rapidapi.com/microsoft-azure-org-microsoft-cognitive-services/api/bing-web-search1/)
1. Prepare the database with `bundle exec rails db:prepare`
   - May need to setup the PostgreSQL roles beforehand
1. Run the server using `foreman start` and browse to it's URL
1. Execute the test suite using `bundle exec rspec`
   - The feature test may fail if Chrome is not installed. Run this command if you have Firefox: `USING_BROWSER=firefox bundle exec rspec`
   - The feature test may fail in headless configs. Run this command if you have headless config: `CI=true bundle exec rspec`

> Note: the `credentials.yml` should have the following structure:
```yml
secret_key_base: -

http_basic:
  username: -
  password: -

rapidapi:
  key: -
```
## Live demo

As always, you can find a live demo in [Heroku](https://infinite-meadow-42034.herokuapp.com/)
> Using free dynos, so, don't expect excellent performance
>
> **Username**: `demo`
> **Password**: `demo`

### Changing the language

When requesting the demo link above and selecting a language, the errors will show in either language when visiting the `/search` endpoint with invalid arguments:

https://infinite-meadow-42034.herokuapp.com/search

### Query endpoint

This is a demo endpoint:

https://infinite-meadow-42034.herokuapp.com/search?engine=both&search=apple

### The Google Search endpoint is slow

It seems that the API service parses the Google homepage, making it really slow. This is not a performance problem with the application. You can make a valid request twice on different browsers/devices and it will use the cached version.

## Authors

👤 **Oever González**

-   GitHub: [@NoTengoBattery](https://github.com/NoTengoBattery/)
-   Twitter: [@NoTengoBattery](https://twitter.com/NoTengoBattery/)
-   LinkedIn: [Oever González](https://linkedin.com/in/NoTengoBattery/)

## Acknowledgments

-   JetBrains for their amazing [JetBrains Mono](https://fonts.google.com/specimen/JetBrains+Mono#about) monospace font family
-   NoTengoBattery for my amazing and time-saving [Rails Template](https://github.com/NoTengoBattery/rails6-webpacker/)

## 📝 License

Open-source under the MIT License. Oever González (c) 2021.
