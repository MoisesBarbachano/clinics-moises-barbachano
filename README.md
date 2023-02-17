# Clinics Sample Project

## Backstory & Mission

Pretend we're an agency, and we're in the process of doing some major updates to one of our apps.
The app was built for a client of ours to help women fight Breast Cancer through early detection.

We want you to build a simple API that will return a list of clinics within a given zipcode.

This API will function as a "middle man" between our applications and the FDA's database of Mammography Clinics. This data is wholey managed by the FDA, we have no control over the data itself.

It's our job instead to consume it, and provide it as a resource for our applications.

The FDA provides this data in the form of a zip file. [You can find their web search here](http://www.fda.gov/Radiation-EmittingProducts/MammographyQualityStandardsActandProgram/ConsumerInformation/ucm113962.htm), the direct link to the zipped file can be found on that page.


## Requirements

- Take this sample Rails application, and add a JSON API to receive a zip code, and return the clinics associated with that code.

- The app must have a Rake task that, when run, will use a service class [^1] to:
    1. Hit the FDA's file endpoint.
    2. Download the zipped text file into memory.
    3. Unzip and parse the text file, importing the data into the database.
      - The solution here needs to be idempotent, meaning it can be run hundreds of times and we'll still get the correct data in the database.
      - Again, we have no control over the source data - it could be updated at any point.

- The app must provide an API endpoint that:
    1. Checks for an `X-Auth-Token` in the header of the request, ensuring that it matches a configured Environment Variable on the server.
        - This will prevent unauthorized requests to the API.
    2. When given a zipcode, returns the clinics near that location in a JSON format.

- Tests are not a feature, they are a **requirement** [^3].
- This project uses [standard](https://github.com/testdouble/standard).
    - Run and fix your code according to standard's requirements (`bundle exec standardrb`).
- Provide a `DETAILS.md` file with your process of solving these problems, snags you hit, things you learned, etc.

## Bonus Points

- When Clinics are created, the app should find the Clinic's latitude and longitude using a Geocoding API[^2].
    - *NOTE*: PLEASE limit the number of records geocoded to 200 per run, this project provides a /LIVE/ Google API Key.

- After geocoding, adjust the API endpoint to return clinics within a radius of the provided zipcode.

- Offloading the lat/long portion to background workers, such as Resque or Sidekiq [^4].

- Use Redis as a caching layer for the API [^4].

- Build a _simple_ Ruby gem that can be used in a project to hit the Rails app and get the clinic data back.
    1. The gem should have a [`configure`](http://brandonhilkert.com/blog/ruby-gem-configuration-patterns/) option, to:
        - Give it the endpoint of the API (ex: where it lives on the internet).
        - Give it the `auth_token` used in the `X-Auth-Token` header for the request.
    2. The gem just has to provide a simple way for hitting the Rails app and returning the JSON, ex: `ClinicSearcher.search(zipcode)`[^5].

[^1]: Meaning this functionality shouldn't all live in the Rakefile. The task itself should delegate to a Ruby service (ex: `ClinicFetcher`).

[^2]: A Google API Key for reverse geocoding has been provided in the project's `.env` file.

[^3]: RSpec is already installed and configured.

[^4]: `REDIS` is already a configured constant in the project, with namespaces per environment.

[^5]: Don't register the gem with RubyGems.org.
