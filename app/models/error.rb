class Error
  include ActiveModel::Serialization
  attr_reader :details, :status, :id, :type

  def initialize(details, status)
    @details = details
    @status = status
    @id = 1
    @type = 'error'
  end
end
