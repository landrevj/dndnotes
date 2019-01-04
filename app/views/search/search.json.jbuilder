json.array!(@objects) do |object|
    if @name
        json.text object.name
    else
        json.text object.content
    end
    json.type object.model_name.name
    json.id   object.id
end
