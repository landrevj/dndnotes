json.motif_color @category.color
json.category_id @category.id
json.notes @notes do |note|
    json.text note.name
    json.id   note.id
end
