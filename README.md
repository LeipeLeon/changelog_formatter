# ChangelogFormatter

TODO:
- put helpers into the class
- better documentation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'changelog_formatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install changelog_formatter

## Usage

### The changelog

### Rails

Controller:

``` ruby
@changelog = ChangelogFormatter.to_a
```

Helper

``` ruby
def changelog_icon_for_type(type)
  capture_haml do
    haml_tag :i, class: "menu-icon fa fa-#{ChangelogFormatter::CHANGELOG_ICONS[type.to_sym]}"
  end
end
```

View (in haml)

``` haml
.col-xs-12
  %p= t(".changelog_intro")
    - ChangelogFormatter::CHANGELOG_ICONS.each do |type, _|
      = changelog_icon_for_type(type)

.col-xs-12
  %table.table-condensed
    %tbody
      - for release in @changelog.each
        %tr
          %th{colspan: 2}
            %h3= release.name
            - if release.date
              .small.text-right
                = release.date
        - for type, text in release.lines
          %tr
            / %td.right= type
            %td= changelog_icon_for_type(type)
            %td= text
```

Translation

``` yaml
nl-NL:
  changelog:
    ago: geleden
    changelog_intro: "We're constantly developing new versions. He're is what we did:"
    changelog:
      new: Nieuw
      fix: Opgeloste bug
      del: Verwijderd
      enh: Optimalisatie
      new: Nieuwe functionaliteit
```


### git-flow

Use this script to generate a release branch, open the CHANGELOG w/ atom
and copy the date into the pasteboard (OSX)

``` bash
release is a function
release ()
{
    CURRENT_DATE=$(date "+%Y-%m-%d-%H%M");
    git flow release start ${CURRENT_DATE};
    echo "Release ${CURRENT_DATE}" | pbcopy;
    [ -e CHANGE* ] && atom CHANGE*
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/changelog_formatter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
