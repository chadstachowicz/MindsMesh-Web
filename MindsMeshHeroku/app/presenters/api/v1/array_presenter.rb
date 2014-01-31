class Api::V1::ArrayPresenter
  attr_accessor :array

  def initialize(array)
    self.array = array
    super()
  end

  def to_json
    array.map(&:as_json)
  end

  def with_parents
    array.map(&:with_parents)
  end

  def with_family
    array.map(&:with_family)
  end

end
