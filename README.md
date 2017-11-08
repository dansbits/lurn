# Lurn

Lurn is a ruby gem for performing machine learning. The API and design patterns in Lurn are inspired by sklearn, an analogous library for Python.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lurn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lurn

## Usage

### Bernoulli Naive Bayes
```ruby
require 'lurn'

documents = [
  'ruby is a great programming language',
  'the giants recently won the world series',
  'java is a compiled programming language',
  'the jets are a football team'
]

labels = ['computers','sports','computers','sports']

# vectorizers take raw data and transform it to a set of features that our
# model can understand - in this case an array of boolean values representing
# the presence or absence of a word in text
vectorizer = Lurn::Text::BernoulliVectorizer.new
vectorizer.fit(documents)
vectors = vectorizer.transform(documents)

model = Lurn::NaiveBayes::BernoulliNaiveBayes.new
model.fit(vectors, labels)

new_vectors = vectorizer.transform(['programming is fun'])
probabilities = model.predict_probabilities(new_vectors.first)
# => [0.9715681919147049, 0.028431808085295614]

# to get the class of the maximum probability, look at the same index of the
# unique_labels attribute on the model
model.unique_labels[0] # => 'computers'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dansbits/lurn.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
