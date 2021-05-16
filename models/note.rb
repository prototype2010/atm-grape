class Note < ActiveRecord::Base
  VALID_NOTES = [1, 2, 5, 10, 25, 50]

  validates :note, uniqueness: true, presence: true, length: { minimum: 1 }, inclusion: { in: VALID_NOTES }
  validates :amount, length: { minimum: 1 }

  class << self
    include CountAlgorithm

    def enough_nominal?(withdraw_amount)
      withdraw_amount <= nominal_total
    end

    def withdraw(amount)
      raise NotEnoughMoneyException unless enough_nominal?(amount)

      notes_details = coerce_number_to_notes(amount, notes_info)
      withdraw_notes(notes_details)

      notes_details
    end

    def withdraw_notes(notes_details)
      transaction do
        notes_details
          .entries
          .each do |nominal, quantity|
          note = find_by(note: nominal)
          note.amount -= quantity
          note.save
        end
      end
    end

    def charge(notes_info)
      transaction do
        notes_info
          .select { |_key, value| !value.nil? && value.positive? }
          .entries
          .each do |note, amount|
          existing_note = where(note: note).first_or_create
          existing_note.amount += amount
          existing_note.save
        end
      end
    end

    def nominal_total
      all
        .map { |note| note.note * note.amount }
        .sum
    end

    def notes_info
      all
        .map { |note_row| [note_row.note, note_row.amount] }
        .to_h
    end
  end
end
