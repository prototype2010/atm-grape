module ValidationHelpers
  VALIDATE_POSITIVE_INT = ->(v) { v.is_a?(Integer) && v.positive? }
end