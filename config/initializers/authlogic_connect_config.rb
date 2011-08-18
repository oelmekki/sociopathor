# This is how your config file should look.
# This is my Heroku config file.
# Heroku recommends setting environment variables on their system

case Rails.env
when "development"
  AuthlogicConnect.config = YAML.load_file("config/authlogic.yml")
when "production"
  AuthlogicConnect.config = {
    :connect => {
      :twitter => {
        :key => 'my_key',
        :secret => 'my_secret',
        :label => "Twitter"
      },
      :facebook => {
        :key => "my_key",
        :secret => "my_secret",
        :label => "Facebook"
      },
      :google => {
        :key => ENV["CONNECT_GOOGLE_KEY"],
        :secret => ENV["CONNECT_GOOGLE_SECRET"],
        :label => "Google"
      },
      :yahoo => {
        :key => ENV["CONNECT_YAHOO_KEY"],
        :secret => ENV["CONNECT_YAHOO_SECRET"],
        :label => "Yahoo"
      },
      :vimeo => {
        :key => ENV["CONNECT_VIMEO_KEY"],
        :secret => ENV["CONNECT_VIMEO_SECRET"],
        :label => "Vimeo"
      },
      :linked_in => {
        :key => ENV["CONNECT_LINKED_IN_KEY"],
        :secret => ENV["CONNECT_LINKED_IN_SECRET"],
        :label => "LinkedIn"
      },
      :myspace => {
        :key => ENV["CONNECT_MYSPACE_KEY"],
        :secret => ENV["CONNECT_MYSPACE_SECRET"],
        :label => "MySpace"
      },
      :github => {
        :key => ENV["CONNECT_GITHUB_KEY"],
        :secret => ENV["CONNECT_GITHUB_SECRET"],
        :label => "Github"
      }
    }
  }
when "test"
  AuthlogicConnect.config = {
    :connect => {
      :twitter => {
        :key => 'my_key',
        :secret => 'my_secret',
        :label => "Twitter"
      },
      :facebook => {
        :key => "my_key",
        :secret => "my_secret",
        :label => "Facebook"
      },
      :google => {
        :key => ENV["CONNECT_GOOGLE_KEY"],
        :secret => ENV["CONNECT_GOOGLE_SECRET"],
        :label => "Google"
      },
      :yahoo => {
        :key => ENV["CONNECT_YAHOO_KEY"],
        :secret => ENV["CONNECT_YAHOO_SECRET"],
        :label => "Yahoo"
      },
      :vimeo => {
        :key => ENV["CONNECT_VIMEO_KEY"],
        :secret => ENV["CONNECT_VIMEO_SECRET"],
        :label => "Vimeo"
      },
      :linked_in => {
        :key => ENV["CONNECT_LINKED_IN_KEY"],
        :secret => ENV["CONNECT_LINKED_IN_SECRET"],
        :label => "LinkedIn"
      },
      :myspace => {
        :key => ENV["CONNECT_MYSPACE_KEY"],
        :secret => ENV["CONNECT_MYSPACE_SECRET"],
        :label => "MySpace"
      },
      :github => {
        :key => ENV["CONNECT_GITHUB_KEY"],
        :secret => ENV["CONNECT_GITHUB_SECRET"],
        :label => "Github"
      }
    }
  }
end
