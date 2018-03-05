# Lurn

Lurn is a ruby gem for performing machine learning tasks. The API and design patterns in Lurn are inspired by scikit-learn, a popular machine learning library for Python.

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

- Naive Bayes
  - [Bernoulli Naive Bayes](readmes/naive_bayes/bernoulli_naive_bayes.md)
- Nearest Neighbor Models
  - [K Nearest Neighbor Regression](readmes/neighbors/knn_regression.md)
- Text Processing
  - [Bernoulli Vectorizer](readmes/text_processing/bernoulli_vectorizer.md)
- Model Evaluation
  - [ClassifierEvaluator](readmes/evaluation/classifier_evaluator.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dansbits/lurn.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
