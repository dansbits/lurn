### K Nearest Neighbor Classifier
K Nearest Neighbor (KNN) Classification is one of the simplest forms of classification
in the machine learning toolbox. Training data is stored on the model and all
computation is deferred until the time of prediction. When a new observation
is provided it calculates the distance between the new observation and all
training data in an n-dimensional space (where n is the number of variables).
The predicted class is the most common class among the k closest training records.

Below is a simple example of using KNN Classification in Lurn.

Suppose we have a dataset containing the income, years of college eduction and job title
for a set of people. We could use this as training data to predict
people's job title based on their income and years of eduction.

  ```ruby
  people = [
    # years of education  annual income job title
    [ 4,                  50000,        'engineer'],
    [ 6,                  60000,        'scientist'],
    [ 2,                  40000,        'engineer'],
    [ 8,                  90000,         'scientist'],
    [ 4,                  70000,        'librarian'],
  ]

  # eduction and income
  predictors = people.map { |person| person[0..1] }

  # extract annual income
  target_var = people.map { |person| person[2]}
  ```

The model can be trained by passing the predictors and target values to an initialized
instance of the KNNClassifier model.

```ruby
  # initialize the model with a k of 2
  model = Lurn::Neighbors::KNNClassifier.new(2)

  model.fit(predictors, target_var)
```

The model can now be used to predict the income of a person given his/her
age and years of education.

```ruby
  # predict the job title of person with 4 years of eduction who make $45,000
  model.predict([4, 45000])  # => engineer
```
