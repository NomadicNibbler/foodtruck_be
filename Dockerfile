# syntax=docker/dockerfile:1
# pulls the ruby image 2.5 from dockerhub
FROM ruby:2.5.3
# updates and installs node.js and postgres
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# sets the working container directory to '/foodtruck_be'
WORKDIR /foodtruck_be
# copies the contents of the gemfile from project to container file
COPY Gemfile /foodtruck_be/Gemfile
# copies the contents of the Gemfile.lock from project to container file
COPY Gemfile.lock /foodtruck_be/Gemfile.lock
# runs bundle
RUN gem install bundler -v 2.2.17
RUN bundle install


# Add a script to be executed every time the container starts.
# copies the entrypoint file to container, this will shut down and other processes to prevent failure
COPY entrypoint.sh /usr/bin/
# changes the entrypoint.sh permissions to executable
RUN chmod +x /usr/bin/entrypoint.sh
# maybe runs the entrypoint file?
ENTRYPOINT ["entrypoint.sh"]
# exposes port 3000 on the container
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
