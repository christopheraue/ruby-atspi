# Atspi

This is a ruby gem that lets you comfortably call the
[Assistive Technology Service Provider Interface](https://en.wikipedia.org/wiki/Assistive_Technology_Service_Provider_Interface)
on Linux.

It wraps Gnome's [libatspi](https://developer.gnome.org/libatspi/stable/) and
exposes it as high level ruby objects.

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
# Get the desktop
desktop = ATSPI.desktops.first

# Get an application on the desktop (here Gnome Terminal)
application = desktop.applications.last

# Get the first window of the application
window = application.windows.first

# Get the window's tabs
tabs = window.descendants.where(role: :page_tab)
tabs.count # => 3

# Get the selected tab
selected_tab = tabs.where(state: :selected).first
selected_tab.index # => 0

# Select the first tab
tabs.last.select

# Get the selected tab
selected_tab = tabs.where(state: :selected).first
selected_tab.index # => 2
```

## Documentation

Detailed documentation can be found at [http://www.rubydoc.info/gems/atspi](http://www.rubydoc.info/gems/atspi).

Especially:

* Everything starts with the [ATSPI module](http://www.rubydoc.info/gems/atspi/ATSPI.html).
* Accessibles are represented by the [ATSPI::Accessible class](http://www.rubydoc.info/gems/atspi/ATSPI/Accessible.html).
+ An accessible's descendants can be searched using the interface of the [ATSPI::Accessible::Descendants class](http://www.rubydoc.info/gems/atspi/ATSPI/Accessible/Descendants.html)

## Todo

Not supported yet are:

* Event listeners
* (Editable) text attributes
