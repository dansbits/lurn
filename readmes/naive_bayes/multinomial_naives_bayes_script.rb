require 'lurn'

def documents
  [ 'ruby is a great programming language',
    'the giants recently won the world series',
    'java is a compiled programming language',
    'the jets are a football team'
  ]
end
# puts "#{documents.last}"

def labels
  ['computers','sports','computers','sports']
end
#puts "#{labels}"

def vectorizer
  @vectorizer ||= Lurn::Text::BernoulliVectorizer.new.tap do |v|
    v.fit(documents)
  end
end

def vectors
  @vectors ||= vectorizer.transform(documents)
end

# puts "#{vectorizer}"

def model
  @model ||= Lurn::NaiveBayes::BernoulliNaiveBayes.new.tap do |m|
    m.fit(vectors, labels)
  end
end

def new_vectors
  @new_vectors ||= vectorizer.transform(['programming is fun'])
end

def categorize_result
  model.max_class(new_vectors.first)
end

def probability_result
  model.max_probability(new_vectors.first)
end

# puts "#{new_vectors.first}"

puts "We think the new vector is #{categorize_result} with a #{probability_result} certainty"
