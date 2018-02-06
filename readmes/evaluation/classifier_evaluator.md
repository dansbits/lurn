# Classifier Evaluator
`Lurn::Evaluation::ClassifierEvaluator` provides some basic functionality for evaluating the performance of a classifier.

## Example
```
actual_class = ['sports','science','science','sports']
predicted_class = ['sports','sports','science','sports']

eval = Lurn::Evaluation::ClassifierEvaluator.new predicted_class, actual_class

print eval.summary

# output
+-----------------+--------------------+--------+
| Class           | Precision          | Recall |
+-----------------+--------------------+--------+
| sports          | 0.6666666666666666 | 1.0    |
| science         | 1.0                | 0.5    |
| Overall Average | 0.8333333333333333 | 0.75   |
+-----------------+--------------------+--------+
```
