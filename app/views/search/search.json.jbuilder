json.motif_color @motif_color
json.type @type_singular
json.objects @objects do |object|
    json.text object.name
    json.id   object.id
end
