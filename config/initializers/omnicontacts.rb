require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "239678273641.apps.googleusercontent.com", "0ZJLQf1r3byhecFFo-_LBtNz",  {:redirect_path => "/invites"}   
  importer :yahoo, "dj0yJmk9UU0zbkRrNWtocGZIJmQ9WVdrOVEyRk1PVko2Tm1zbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0zYg--", "04055aab0521d55c024ca018865d31ab3f554552", {:callback_path => '/yahoo_callback'}
  importer :hotmail, "0000000044101B81", "cZ4k5kpZeTneQFMUCKnxIhOQ7tOjA5UN"
end