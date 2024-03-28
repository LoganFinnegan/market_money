class ErrorSerializer
  attr_reader :object_error
  
  def initialize(object_error)
    @object_error = object_error
  end

  def serialize_json
    {
       "errors": [
           {
               "status": @object_error.status_code,
               "detail": @object_error.message
           }
       ]
   }
  end
end
