module CountAlgorithm
  def coerce_number_to_notes(amount, all_notes_hash)
    sum = 0

    nominal_to_take = all_notes_hash
                        .entries
                        .sort_by { |nominal, _quantity| nominal }
                        .reverse
                        .map do |nominal, quantity|
      next if sum == amount || quantity == 0

      rest_sum = amount - sum

      next if rest_sum < nominal

      optimistic_take = rest_sum / nominal
      will_be_taken = quantity > optimistic_take ? optimistic_take : quantity
      sum += will_be_taken * nominal

      [nominal, will_be_taken]
    end

    raise NoNominalException if sum != amount

    nominal_to_take.compact.to_h
  end
end