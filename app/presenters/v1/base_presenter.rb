class V1::BasePresenter
  attr_accessor :m

  def initialize(model)
    self.m = model
  end

  def self.array(models)
    models.map { |m| new m }
  end
end
