module Lurn
  class KDTree

    attr_reader :left_tree
    attr_reader :right_tree
    attr_reader :partition_dimension
    attr_reader :partition
    attr_reader :vector

    def initialize(vectors, partition_dimension = 0)
      self.partition_dimension = partition_dimension

      if vectors.count == 1
        self.vector = vectors[0]
      else
        partition_vectors(vectors)
      end
    end

    def pretty_print(depth = 0)
      output = ""
      output += "root:\n" if depth == 0
      output += ("  ") * (depth + 1) + "left_tree: v[#{partition_dimension}] <= #{partition}\n#{left_tree.pretty_print(depth+1)}" if @left_tree
      output += ("  ") * (depth + 1) + "right_tree: v[#{@partition_dimension}] > #{partition}\n#{right_tree.pretty_print(depth+1)}" if @right_tree
      if @left_tree.nil? && @right_tree.nil?
        if vector
          output += ("  ") * (depth + 1) + vector.to_s + "\n"
        else
          output += ("  ") * (depth + 1) + "LEAF NODE"
        end
      end
      output
    end
    
    private

    vectors.sort! { |v1, v2| v1[partition_dimension] <=> v2[@partition_dimension] }
    def partition_vectors(vectors)
      median_index = (vectors.length / 2) - 1
      partition = vectors[median_index][partition_dimension]

      left_vectors = vectors[0..median_index]
      right_vectors = vectors[(median_index + 1)..-1]

      left_tree = build_child(left_vectors)
      right_tree = build_child(right_vectors)
    end

    def build_child(vectors)
      if vectors.any?
        next_dimension =  (@partition_column + 1) % vectors[0].length

        KDTree.new(vectors, next_dimension)
      end
    end

  end
end