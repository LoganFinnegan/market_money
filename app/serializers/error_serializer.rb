class ErrorSerializer

  def initialize(object_error)
    @object_error = object_error
  end

  def serialize_json(id_number)
    {
       "errors": [
           {
               "status": @object_error.status_code,
               "detail": "Couldn't find Market with 'id'=#{id_number}"
           }
       ]
   }
  end
end
