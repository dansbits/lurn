### Multinomial Naive Bayes
Naive bayes is a bayesian model often used for text classification. Multinomial Naive Bayes specifically classifies observations based on variables with a multinomial distribution (a.k.a. numbers).

Below is a simple text classification using Multinomial Naive Bayes in Lurn.

1. Start with some text documents

  ```ruby
  documents = [
    'ruby is a great programming language',
    'the giants recently won the world series',
    'java is a compiled programming language',
    'the jets are a football team'
  ]

  labels = ['computers','sports','computers','sports']
  ```

2. Convert them to arrays of booleans representing which words they contain (or don't contain). Lurn provides vectorizers for this purpose.
  ```
  vectorizer = Lurn::Text::WordCountVectorizer.new
  vectorizer.fit(documents)
  vectors = vectorizer.transform(documents)
  ```

3. Initialize and train the model
  ```
  model = Lurn::NaiveBayes::MultinomialNaiveBayes.new
  model.fit(vectors, labels)
  ```

4. Classify a new document
  ```
  new_vectors = vectorizer.transform(['programming is fun'])

  # get the most probable class for the new document given the training data
  model.max_class(new_vectors.first)

  # get the probability score for the most probable class
  model.max_probability(new_vectors.first)
  ```
