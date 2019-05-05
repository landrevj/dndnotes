if @category
  json.motif_color @category.color
  json.category_id @category.id
end
json.notes @notes do |note|
  json.text note.name
  json.id   note.id
end
