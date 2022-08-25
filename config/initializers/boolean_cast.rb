# Module for true? function injection
#
# For use in checking ENV
module BooleanCast
  TRUE_VALUES = [true, 1, '1', 't', 'true', 'on', 'yes'].to_set.freeze

  # Cast from string to bool
  def true?
    if is_a?(String)
      TRUE_VALUES.include?(downcase)
    else
      TRUE_VALUES.include?(self)
    end
  end

  def false?
    !true?
  end
end

['s', 1, 1.2, true, false, nil].each { |v| v.class.prepend(BooleanCast) }
