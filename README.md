# Atspi

A ruby wrapper around [libatspi](https://developer.gnome.org/libatspi/stable/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'atspi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atspi

## Getting Started

```ruby
desktop = ATSPI.desktops.first
application = ATSPI.applications(desktop).last
windows = application.windows
```

## Documentation



## Todo

* Event listeners
* (Editable) text attributes
