class Endure::QueryResult
  attr_accessor :matching, :returned, :documents, :store

  def initialize
    @matching  = 0
    @returned  = 0
    @documents = []
    @objects   = []
    @inflated  = false
  end

  def objects
    inflate unless @inflated
    @objects
  end

  def objects=(value)
    @objects = value
  end

  private

  def inflate
    if @store.nil?
      raise ArgumentError, 'Key/Value Store configuration must be set before attempting to access objects'
    end

    @objects  = @store.multi_get(documents.map { |d| d[:key] })
    @inflated = true
    @objects
  end
end
