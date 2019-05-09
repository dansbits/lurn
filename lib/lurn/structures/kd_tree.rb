module Lurn
  class KdTree

    attr_reader :left_tree
    attr_reader :right_tree
    attr_reader :partition_dimension
    attr_reader :partition
    attr_reader :vector
    attr_reader :vector_count

    def initialize(vectors, partition_dimension = 0)
      @partition_dimension = partition_dimension

      if all_equal?(vectors)
        @vector = vectors[0]
        @vector_count = vectors.count
      else
        partition_vectors(vectors)
      end
    end

    def k_nearest_neighbors(vector, k: 1)

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

    def all_equal?(vectors)
      equal = true
      sample_vector = vectors.first

      vectors.each do |v| 
        if v != sample_vector
          equal = false
          break
        end
      end

      equal
    end

    def partition_vectors(vectors)
      vectors.sort! { |v1, v2| v1[partition_dimension] <=> v2[@partition_dimension] }
      median_index = (vectors.length / 2) - 1
      @partition = vectors[median_index][partition_dimension]

      left_vectors = vectors.select { |v| v[partition_dimension] <= partition }
      right_vectors = vectors.select { |v| v[partition_dimension] > partition }

      @left_tree = build_child(left_vectors)
      @right_tree = build_child(right_vectors)
    end

    def build_child(vectors)
      if vectors.any?
        next_dimension = (@partition_dimension + 1) % vectors[0].length

        KdTree.new(vectors, next_dimension)
      end
    end

  end
end