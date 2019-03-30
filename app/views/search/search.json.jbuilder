json.motif_color @motif_color
json.type @type_singular
json.objects @objects do |object|
    if @name
        json.text object.name
    else
        json.text object.content
    end
    json.id   object.id
end
