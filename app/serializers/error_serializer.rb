class ErrorSerializer
  attr_reader :object_error
  
  def initialize(object_error)
    @object_error = object_error
  end

  def serialize_json
    {
       "errors": [
           {
               "detail": @object_error.message
           }
       ]
   }
  end
end
