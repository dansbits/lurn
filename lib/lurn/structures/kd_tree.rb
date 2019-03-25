module Lurn
  class KDTree

    attr :left_tree
    attr :right_tree
    attr :partition_column
    attr :partition

    def initialize(vectors, partition_column = 0)
      @partition_column = partition_column
      @left_tree = nil
      @right_tree = nil
      if vectors.count == 1
        @vector = vectors[0]
      else
        partition_vectors(vectors)
      end
    end

    def pretty_print(depth = 0)
      output = ""
      output += "root:\n" if depth == 0
      output += ("  ") * (depth + 1) + "left_tree: v[#{@partition_column}] <= #{@partition}\n#{@left_tree.pretty_print(depth+1)}" if @left_tree
      output += ("  ") * (depth + 1) + "right_tree: v[#{@partition_column}] > #{@partition}\n#{@right_tree.pretty_print(depth+1)}" if @right_tree
      if @left_tree.nil? && @right_tree.nil?
        if @vector
          output += ("  ") * (depth + 1) + @vector.to_s + "\n"
        else
          output += ("  ") * (depth + 1) + "LEAF NODE"
        end
      end
      output
    end
    
    private

    def partition_vectors(vectors)
      vectors.sort! { |v1, v2| v1[@partition_column] <=> v2[@partition_column] }
      median_index = (vectors.length / 2) - 1
      @partition = vectors[median_index][@partition_column]

      left_vectors, right_vectors = [], []
      vectors.each do |v|
        if v[@partition_column] <= @partition
          left_vectors.push v
        else
          right_vectors.push v
        end
      end

      @left_tree = build_child(left_vectors)
      @right_tree = build_child(right_vectors)
    end

    def build_child(vectors)
      if vectors.any?
        next_dimension =  (@partition_column + 1) % vectors[0].length

        KDTree.new(vectors, next_dimension)
      end
    end

  end
end